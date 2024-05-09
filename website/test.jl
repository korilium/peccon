using Pkg
Pkg.add(name = "SimpleWebsockets", version = "0.1.4")
using SimpleWebsockets

server = WebsocketServer()

listen(server, :client) do ws   
    listen(ws, :message) do message
        try
            comm = Meta.parse(message)
            result = Base.eval(@__MODULE__, comm)
            send(ws, string(result))
        catch err
            @error err
            send(ws, "Could not run command")
        end
    end
end
function echo(val)
    return val
end
serve(server, 8081)