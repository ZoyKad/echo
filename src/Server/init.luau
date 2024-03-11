local Events = require(script.Parent.Events)
local Server = {}

local function onActionBegan(player: Player, actionName: string, infos: {}?)
    Events.actionBegan:Server():FireAllExcept(player, actionName, infos)
end

local function onActionEnded(player: Player, actionName: string, infos: {}?)
    Events.actionEnded:Server():FireAllExcept(player, actionName, infos)
end

local function onActionUpdated(player: Player, actionName: string, infos: {}?)
    Events.actionUpdated:Server():FireAllExcept(player, actionName, infos)
end

local function setupServer()
    Events.actionUpdated:Server():On(onActionUpdated)
    Events.actionBegan:Server():On(onActionBegan)
    Events.actionEnded:Server():On(onActionEnded)
    
    return Server
end

return setupServer()