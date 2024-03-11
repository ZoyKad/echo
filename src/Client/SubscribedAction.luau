local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)
local Trove = require(ReplicatedStorage.Packages.Trove)

local SubscribedAction = {}

local SUBCRIBED_ACTION_METATABLE = {
    __index = SubscribedAction,
}

local function newSubscribedAction(actionName: string): SubscribedAction
    local self = setmetatable({}, SUBCRIBED_ACTION_METATABLE)
    
    self._trove = Trove.new()

    self.updated = Signal.new()
    self.ended = Signal.new()

    self._trove:Add(self.updated)
    self._trove:Add(self.ended)

    local function cleanup()
        self._trove:Clean()
    end
    
    self._trove:Connect(self.ended, cleanup)
    
    return self
end

export type SubscribedAction = typeof(newSubscribedAction(...))

return newSubscribedAction