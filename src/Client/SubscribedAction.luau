local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)

local function newSubscribedAction(actionName: string): SubscribedAction
    local self = {
        actionBegan = Signal.new(),
        actionUpdated = Signal.new(),
        actionEnded = Signal.new(),
    }
    
    return self
end

export type SubscribedAction = typeof(newSubscribedAction(...))

return newSubscribedAction