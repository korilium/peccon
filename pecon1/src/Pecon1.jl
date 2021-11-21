module Pecon1

using Genie, Logging, LoggingExtras

function main()
  Base.eval(Main, :(const UserApp = Pecon1))

  Genie.genie(; context = @__MODULE__)

  Base.eval(Main, :(const Genie = Pecon1.Genie))
  Base.eval(Main, :(using Genie))
end

end
