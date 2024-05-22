using Pkg

Pkg.activate("/home/korilium/Documents/GitHub/peccon/")

using Franklin, Debugger, FranklinTemplates


newsite("Peccon", template="basic")

#run the Peccon example

cd("FranklinWebsite/Peccon")
serve()