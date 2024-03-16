local RunService = game:GetService("RunService")

local Config = require(script.Parent.Config)

local isServer = RunService:IsServer()
local function placeHolderFunction(...) end

local Logger = {
    log = if isServer and Config.serverLogs or (not isServer and Config.clientLogs) then print else placeHolderFunction,
    warn = if isServer and Config.serverLogs or (not isServer and Config.clientLogs) then warn else placeHolderFunction
}

return Logger