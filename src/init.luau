local RunService = game:GetService("RunService")

local Client = require(script.Client)
local Server = require(script.Server)

export type SubscribedAction = Client.SubscribedAction
export type ServedAction = Client.ServedAction

if RunService:IsClient() then
    return Client
else
    return Server
end