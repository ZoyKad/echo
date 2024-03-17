local Events = require(script.Parent.Parent.Events)
local Logger = require(script.Parent.Parent.Logger)
local Signal = require(script.Parent.Parent.Parent.Signal)
local Trove = require(script.Parent.Parent.Parent.Trove)

local ServedAction = {}

local ACTION_MT = {__index = ServedAction}

local function newAction(name: string, id: string)
    local self = setmetatable({}, ACTION_MT)
    
    self.name = name
    self.id = id

    self._trove = Trove.new()
    self._destroying = Signal.new()

    self._trove:Add(self._destroying)
    
    return self
end

export type ServedAction = typeof(newAction(...))

function ServedAction.Start(self: ServedAction, infos: {any})
    Logger.log("Action started", self.name, self.id, infos)

    Events.actionBegan:Client():Fire(self.name, self.id, infos)
end

function ServedAction.Dispatch(self: ServedAction, eventName: string, infos: {any})
    Logger.log("Action updated", self.name, self.id, eventName, infos)

    Events.actionUpdated:Client():Fire(self.id, eventName, infos)
end

function ServedAction.End(self: ServedAction, infos: {any})
    Logger.log("Action ended", self.name, self.id, infos)

    Events.actionEnded:Client():Fire(self.id, infos)
    
    self._destroying:Fire()
    self._trove:Clean()
    table.clear(self)
    table.freeze(self)
end

return newAction