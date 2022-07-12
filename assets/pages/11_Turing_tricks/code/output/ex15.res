Chains MCMC chain (2000×21×4 Array{Float64, 3}):

Iterations        = 1001:1:3000
Number of chains  = 4
Samples per chain = 2000
Wall duration     = 24.93 seconds
Compute duration  = 44.09 seconds
parameters        = α, β[1], β[2], β[3], β[4], σ, τ, zⱼ[1], zⱼ[2]
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
  parameters       mean       std   naive_se      mcse        ess      rhat   ess_per_sec
      Symbol    Float64   Float64    Float64   Float64    Float64   Float64       Float64

           α    69.9159    6.6602     0.0745    0.5875    30.6958    1.1845        0.6963
        β[1]     3.1214    1.2253     0.0137    0.0421   642.5782    1.0099       14.5756
        β[2]   -11.5502    1.3516     0.0151    0.0669   125.5810    1.0382        2.8485
        β[3]     7.2289    1.2330     0.0138    0.0443   400.1176    1.0155        9.0758
        β[4]     1.2194    1.2141     0.0136    0.0376   681.9825    1.0099       15.4694
           σ     6.0003    0.2686     0.0030    0.0076   805.1864    1.0000       18.2640
           τ     6.2248    4.0846     0.0457    0.3290    40.0704    1.1324        0.9089
       zⱼ[1]    -0.7283    0.8834     0.0099    0.0508    82.4694    1.0499        1.8706
       zⱼ[2]     0.8675    0.8297     0.0093    0.0370   260.0401    1.0232        5.8985

Quantiles
  parameters       2.5%      25.0%      50.0%      75.0%     97.5%
      Symbol    Float64    Float64    Float64    Float64   Float64

           α    48.8450    68.2230    70.7640    73.1940   82.1199
        β[1]     0.7495     2.3063     3.1935     3.9046    5.5489
        β[2]   -14.0633   -12.4951   -11.6069   -10.6642   -8.7061
        β[3]     4.7462     6.3871     7.2639     8.0787    9.4428
        β[4]    -1.2129     0.4152     1.2562     2.0669    3.4827
           σ     5.4763     5.8217     5.9965     6.1815    6.5276
           τ     1.9555     3.3459     4.8809     7.5366   17.2835
       zⱼ[1]    -2.4093    -1.3030    -0.7673    -0.2031    1.0556
       zⱼ[2]    -0.6957     0.2597     0.8859     1.4299    2.5097
