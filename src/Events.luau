local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Guard = require(ReplicatedStorage.Packages.Guard)
local Red = require(ReplicatedStorage.Packages.Red)

local function actionUpdateCheck(actionName, eventName, actionInfos)
    return Guard.String(actionName), Guard.String(eventName), Guard.Optional(Guard.Map(Guard.String, Guard.Any))(actionInfos)
end

local function actionBeganOrEnd(actionName, actionInfos)
    return Guard.String(actionName), Guard.Optional(Guard.Map(Guard.String, Guard.Any))(actionInfos)
end

local Events = {
    actionBegan = Red.Event("ActionBegan", actionBeganOrEnd),
    actionEnded = Red.Event("ActionEnded", actionBeganOrEnd),
    actionUpdated = Red.Event("ActionChanged", actionUpdateCheck),
}

return Events