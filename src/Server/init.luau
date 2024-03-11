local Events = require(script.Parent.Events)

local Server = {}

local function onActionBegan(...): ()
    Events.actionBegan:Server():FireAllExcept(...)
end

local function onActionEnded(...): ()
    Events.actionEnded:Server():FireAllExcept(...)
end

local function onActionUpdated(...): ()
    Events.actionUpdated:Server():FireAllExcept(...)
end

local function setupServer()
    Events.actionUpdated:Server():On(onActionUpdated)
    Events.actionBegan:Server():On(onActionBegan)
    Events.actionEnded:Server():On(onActionEnded)
    
    return Server
end

return setupServer()