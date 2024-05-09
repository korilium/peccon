using Pkg

Pkg.activate("/home/korilium/Documents/GitHub/peccon")

using Franklin 

newsite("website/doc")

serve()