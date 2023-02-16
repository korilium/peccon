module MarketsController

using Genie.Renderer.Html, SearchLight, Peccon2.Markets




# function index()
#   "Welcome to movies list!"
# end
function index()
  html(:markets, :index, markets = rand(Market))
end

end
