using Genie.Router

route("/") do
  serve_static_file("welcome.html")
end

using Peccon2.MarketsController

route("/models", MarketsController.index)