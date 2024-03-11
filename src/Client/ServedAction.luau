local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Events = require(ReplicatedStorage.ActionManager.Events)

local ServedAction = {}

local ACTION_MT = {__index = ServedAction}

local function newAction(name: string)
    local self = setmetatable({}, ACTION_MT)
    
    self.name = name
    
    return self
end

export type ServedAction = typeof(newAction(...))

function ServedAction.Start(self: ServedAction, infos: {any})
    Events.actionBegan:Client():Fire(self.name, infos)
end

function ServedAction.Dispatch(self: ServedAction, eventName: string, infos: {any})
    Events.actionUpdated:Client():Fire(self.name, eventName, infos)
end

function ServedAction.End(self: ServedAction, infos: {any})
    Events.actionEnded:Client():Fire(self.name, infos)
end


return newAction