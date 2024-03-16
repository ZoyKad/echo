local Events = require(script.Parent.Events)
local Logger = require(script.Parent.Logger)

local Server = {}

local function onActionBegan(...): ()
    Logger.log("Action began")

    Events.actionBegan:Server():FireAllExcept(...)
end

local function onActionEnded(...): ()
    Logger.log("Action ended")

    Events.actionEnded:Server():FireAllExcept(...)
end

local function onActionUpdated(...): ()
    Logger.log("Action updated")

    Events.actionUpdated:Server():FireAllExcept(...)
end

local function setupServer()
    Logger.log("Setting up server...")

    Events.actionUpdated:Server():On(onActionUpdated)
    Events.actionBegan:Server():On(onActionBegan)
    Events.actionEnded:Server():On(onActionEnded)
    
    return Server
end

export type Server = typeof(setupServer())

return setupServer