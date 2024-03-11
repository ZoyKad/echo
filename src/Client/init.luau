local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Events = require(script.Parent.Events)
local Guard = require(ReplicatedStorage.Packages.Guard)
local ServedAction = require(script.ServedAction)
local SubscribedAction = require(script.SubscribedAction)

export type ServedAction = ServedAction.ServedAction
export type SubscribedAction = SubscribedAction.SubscribedAction

local subActionPool = {}
local subCallbacks = {}
local servedActionPool = {}

local Client = {
    ServedAction = ServedAction,
    SubscribedAction = SubscribedAction
}

function Client:RegisterAction(name: string): ServedAction
    assert(Guard.String(name), "Invalid argument #1 to RegisterAction (string expected)")

    local id = HttpService:GenerateGUID()

    local newAction = ServedAction(name, id)
    servedActionPool[id] = newAction

    local function removeAction()
        servedActionPool[id] = nil
    end

    newAction._destroying:Connect(removeAction)
    
    return newAction
end

function Client:SubscribeToAction(name: string, callback: (SubscribedAction, any?) -> ()): ()
    assert(Guard.String(name), "Invalid argument #1 to SubscribeToAction (string expected)")

    subCallbacks[name] = callback
end

local function onActionBegan(actionId: string, actionName: string, ...): ()
    local subAction = SubscribedAction(actionName)
    subActionPool[actionId] = subAction

    local function removeAction()
        subActionPool[actionId] = nil
    end

    subAction.ended:Connect(removeAction)
    
    subCallbacks[actionName](subAction,  ...)
end

local function onActionUpdated(actionId: string, ...): ()
    if subActionPool[actionId] then
        subActionPool[actionId].actionUpdated:Fire(...)
    end
end

local function onActionEnded(actionId: string, ...): ()
    if subActionPool[actionId] then
        subActionPool[actionId].actionEnded:Fire(...)
    end
end

local function setupClient(): typeof(Client)
    Events.actionBegan:Client():On(onActionBegan)
    Events.actionUpdated:Client():On(onActionUpdated)
    Events.actionEnded:Client():On(onActionEnded)

    return Client
end

return setupClient()