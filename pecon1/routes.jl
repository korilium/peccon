using Genie.Router

route("/") do
  serve_static_file("welcome.html")
end

route("/profile") do
  serve_static_file("profile.html")
end