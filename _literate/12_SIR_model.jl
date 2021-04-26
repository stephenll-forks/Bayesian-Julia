# # Bonus: SIR Model

# WIP!
# using Brazil's data

using Downloads, DataFrames, CSV, GZip, Chain, Dates

url = "https://data.brasil.io/dataset/covid19/caso_full.csv.gz"
file = Downloads.download(url)
df = CSV.File(GZip.open(file, "r")) |> DataFrame

# Getting only national-level data in 2021

br = @chain df begin
    filter([:date, :city] => (date, city) -> date > Dates.Date("2021-01-01") && ismissing(city), _)
    groupby(:date)
    combine(
        [:estimated_population_2019,
         :last_available_confirmed_per_100k_inhabitants,
         :last_available_deaths,
         :new_confirmed,
         :new_deaths] .=> sum .=>
         [:estimated_population_2019,
         :last_available_confirmed_per_100k_inhabitants,
         :last_available_deaths,
         :new_confirmed,
         :new_deaths]
    )
end;

# Let's take a look in the first observations

first(br, 5)

# Also the bottom rows

last(br, 5)

# getting variables from the data

infected = br[:, :new_confirmed];
i₀ = first(br[:, :new_confirmed]);
N = first(br[:, :estimated_population_2019]);

# The differential equation
# Taken from https://github.com/epirecipes/sir-julia
# The following function provides the derivatives of the model, which it changes in-place.
# State variables and parameters are unpacked from u and p; this incurs a slight performance hit,
# but makes the equations much easier to read.

# A variable is included for the cumulative number of infections, $C$.

using DifferentialEquations

function sir_ode!(du, u, p, t)
    (S, I, R) = u
    (β, γ) = p
    N = S + I + R
    infection = β * I * S / N
    recovery = γ * I
    @inbounds begin
        du[1] = -infection # Susceptible
        du[2] = infection - recovery # Infected
        du[3] = recovery # Recovered
    end
    nothing
end;

# Turing Model

using Turing

Turing.setadbackend(:forwarddiff)

@model bayes_sir(infected, i₀, N) = begin
  # Calculate number of timepoints
  l = length(infected)
  β ~ TruncatedNormal(2, 1, 0, Inf)
  γ ~ TruncatedNormal(0.4, 0.5, 0, Inf)
  #ϕ⁻ ~ Truncated(Exponential(5), 1, 999)
  #ϕ = 1.0 / ϕ⁻
  I = i₀
  u0 = [N - I, I, 0.0] # # S,I,R
  p = [β, γ] # # β,γ
  tspan = (0.0, float(l))
  prob = ODEProblem(sir_ode!,
          u0,
          tspan,
          p)
  sol = solve(prob,
              Tsit5(),
              saveat=1.0)
  sol_I = Array(sol)[3, :] # New Infected cases
  #infected .~ NegativeBinomial.(sol_I, ϕ)
  infected .~ Poisson.(sol_I)
end;

# Now run the model

chn = sample(bayes_sir(infected, i₀, N), NUTS(0.65), 10000);


# Solving the equation
tmax = 40.0
tspan = (0.0, tmax)
obstimes = 1.0:1.0:tmax
u0 = [990.0, 10.0, 0.0, 0.0] # S,I,R,C
p = [1, 0.4]; # β,γ

prob_ode = ODEProblem(sir_ode!, u0, tspan, p);
sol_ode = solve(prob_ode,
            Tsit5(),
            saveat=1.0);

using StatsPlots
plot(sol_ode)