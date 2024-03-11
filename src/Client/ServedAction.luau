local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Events = require(ReplicatedStorage.ActionManager.Events)
local Signal = require(ReplicatedStorage.Packages.Signal)

local ServedAction = {}

local ACTION_MT = {__index = ServedAction}

local function newAction(name: string, id: string)
    local self = setmetatable({}, ACTION_MT)
    
    self.name = name
    self.id = id

    self._destroying = Signal.new()
    
    return self
end

export type ServedAction = typeof(newAction(...))

function ServedAction.Start(self: ServedAction, infos: {any})
    Events.actionBegan:Client():Fire(self.name, self.id, infos)
end

function ServedAction.Dispatch(self: ServedAction, eventName: string, infos: {any})
    Events.actionUpdated:Client():Fire(self.id, eventName, infos)
end

function ServedAction.End(self: ServedAction, infos: {any})
    Events.actionEnded:Client():Fire(self.id, infos)
    
    self._destroyed:Fire()
    table.clear(self)
    table.freeze(self)
end

return newAction