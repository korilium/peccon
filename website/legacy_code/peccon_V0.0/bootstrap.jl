pwd() == joinpath(@__DIR__, "bin") && cd(@__DIR__) # allow starting app from bin/ dir

using Peccon
push!(Base.modules_warned_for, Base.PkgId(Peccon))
Peccon.main()
