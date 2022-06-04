pwd() == joinpath(@__DIR__, "bin") && cd(@__DIR__) # allow starting app from bin/ dir

using Peccon1
push!(Base.modules_warned_for, Base.PkgId(Peccon1))
Peccon1.main()
