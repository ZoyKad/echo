local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Events = require(script.Parent.Events)
local Guard = require(ReplicatedStorage.Packages.Guard)
local ServedAction = require(script.ServedAction)
local SubscribedAction = require(script.SubscribedAction)

local subActionPool = {}
local servedActionPool = {}

local Client = {}

function Client:RegisterAction(name: string): ServedAction.ServedAction
    assert(Guard.String(name), "Invalid argument #1 to RegisterAction (string expected)")
    
    if servedActionPool[name] then
        return servedActionPool[name]
    end

    local newAction = ServedAction(name)
    servedActionPool[name] = newAction
    
    return newAction
end

function Client:SubscribeToAction(name: string): SubscribedAction.SubscribedAction
    assert(Guard.String(name), "Invalid argument #1 to SubscribeToAction (string expected)")

    if subActionPool[name] then
        return subActionPool[name]
    end

    local newAction = SubscribedAction(name)
    subActionPool[name] = newAction
    
    return newAction
end

local function onActionBegan(actionName: string, ...)
    if subActionPool[actionName] then
        subActionPool[actionName].actionBegan:Fire(...)
    end
end

local function onActionUpdated(actionName: string, ...)
    if subActionPool[actionName] then
        subActionPool[actionName].actionUpdated:Fire(...)
    end
end

local function onActionEnded(actionName: string, ...)
    if subActionPool[actionName] then
        subActionPool[actionName].actionEnded:Fire(...)
    end
end

local function setupClient()
    Events.actionBegan:Client():On(onActionBegan)
    Events.actionUpdated:Client():On(onActionUpdated)
    Events.actionEnded:Client():On(onActionEnded)

    return Client
end

return setupClient()