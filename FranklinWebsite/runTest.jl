using Pkg

Pkg.activate("/home/korilium/Documents/GitHub/peccon/")




using FranklinTemplates: newsite
using Franklin, FranklinTemplates


cd("FranklinWebsite/TestWebsite")
serve()