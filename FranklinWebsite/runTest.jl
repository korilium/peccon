using Pkg

Pkg.activate("/home/korilium/Documents/GitHub/peccon/")




using FranklinTemplates: newsite
using Franklin, FranklinTemplates

# newsite("test", template= "lanyon")
cd("FranklinWebsite/test")
serve()