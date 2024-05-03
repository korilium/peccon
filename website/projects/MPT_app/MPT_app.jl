using Pkg
Pkg.activate("website/projects/MPT_app/MPT_app")


using Genie, Peccon


route("/hello") do 
    "Hello World!" 
end 

up()