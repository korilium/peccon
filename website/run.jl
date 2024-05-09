using Pkg

#activate environemnt
Pkg.activate("/home/korilium/Documents/GitHub/peccon")
#load in package 
using Franklin 
# point to the correct folder
cd("website/doc")
#load in the server
serve()