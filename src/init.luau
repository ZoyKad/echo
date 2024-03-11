local RunService = game:GetService("RunService")

local Client = require(script.Client)
local Server = require(script.Server)

if RunService:IsClient() then
    return Client
else
    return Server
end