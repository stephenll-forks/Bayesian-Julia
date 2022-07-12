# This file was generated, do not modify it. # hide
@model function varying_slope(X, idx, y; n_gr=length(unique(idx)), predictors=size(X, 2))
    #priors
    α ~ Normal(mean(y), 2.5 * std(y))                   # population-level intercept
    σ ~ Exponential(1 / std(y))                         # residual SD
    #prior for variance of random slopes
    #usually requires thoughtful specification
    τ ~ filldist(truncated(Cauchy(0, 2), 0, Inf), n_gr) # group-level slopes SDs
    βⱼ ~ filldist(Normal(0, 1), predictors, n_gr)       # group-level standard normal slopes

    #likelihood
    ŷ = α .+ X * βⱼ * τ
    y ~ MvNormal(ŷ, σ)
end;