local HttpService = game:GetService("HttpService")

local Events = require(script.Parent.Events)
local Logger = require(script.Parent.Logger)
local Guard = require(script.Parent.Parent.Guard)
local ServedAction = require(script.ServedAction)
local SubscribedAction = require(script.SubscribedAction)

export type ServedAction = ServedAction.ServedAction
export type SubscribedAction = SubscribedAction.SubscribedAction

local subActionPool = {}
local subCallbacks = {}
local servedActionPool = {}

local Client = {}

local function onActionBegan(actionName: string, actionId: string, ...): ()
    local subAction = SubscribedAction(actionName)
    subActionPool[actionId] = subAction

    local function removeAction()
        subActionPool[actionId] = nil
    end

    subAction.ended:Connect(removeAction)

    Logger.warn(actionName)
    
    local callback = subCallbacks[actionName]
    if not callback then return end

    callback(subAction,  ...)
end

local function onActionUpdated(actionId: string, ...): ()
    if subActionPool[actionId] then
        subActionPool[actionId].updated:Fire(...)
    end
end

local function onActionEnded(actionId: string, ...): ()
    if subActionPool[actionId] then
        subActionPool[actionId].ended:Fire(...)
    end
end

local function setupClient(): typeof(Client)
    Logger.log("Setting up client...")
    
    Events.actionBegan:Client():On(onActionBegan)
    Events.actionUpdated:Client():On(onActionUpdated)
    Events.actionEnded:Client():On(onActionEnded)

    return Client
end

export type Client = typeof(setupClient())

function Client.RegisterAction(self: Client, name: string): ServedAction
    assert(Guard.String(name), "Invalid argument #1 to RegisterAction (string expected)")

    Logger.log("Registered action: " .. name)

    local id = HttpService:GenerateGUID()

    local newAction = ServedAction(name, id)
    servedActionPool[id] = newAction

    local function removeAction()
        servedActionPool[id] = nil
    end

    newAction._destroying:Connect(removeAction)
    
    return newAction
end

function Client.SubscribeToAction(self: Client, name: string, callback: (SubscribedAction, any?) -> ()): ()
    assert(Guard.String(name), "Invalid argument #1 to SubscribeToAction (string expected)")

    Logger.log("Subscribed to action: " .. name)
    subCallbacks[name] = callback
end

return setupClient