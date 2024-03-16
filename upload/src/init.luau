local RunService = game:GetService("RunService")

local Client = require(script.Client)
local Server = require(script.Server)

export type SubscribedAction = Client.SubscribedAction
export type ServedAction = Client.ServedAction

local clientModule, serverModule = nil, nil
local isServer = RunService:IsServer()

if isServer then
    serverModule = Server()
else
    clientModule = Client()
end

return setmetatable({
    Client = clientModule,
    Server = serverModule,
}, {
    __index = function(_, key)
        if isServer and key == "Client" then
            error("Client module can only be called on the client !")
        elseif not isServer and key == "Server" then
            error("Server module can only be called on the server !")
        end
    end,
})