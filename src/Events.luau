local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Guard = require(ReplicatedStorage.Packages.Guard)
local Red = require(ReplicatedStorage.Packages.Red)

local guards = {
    infos = Guard.Optional(
        Guard.Or(
            Guard.Map(Guard.String, Guard.Any),
            Guard.List(Guard.Any)
        )
    ),

    id = Guard.String,
    actionName = Guard.String,
    eventName = Guard.String,
}

local function actionBeganCheck(id, eventName, infos)
    return guards.id(id), guards.eventName(eventName), guards.infos(infos)
end

local function actionEndedCheck(id, infos)
    return guards.id(id), guards.infos(infos)
end

local function actionUpdateCheck(id, infos)
    return guards.id(id), guards.infos(infos)
end

local Events = {
    actionBegan = Red.Event("ActionBegan", actionBeganCheck),
    actionEnded = Red.Event("ActionEnded", actionEndedCheck),
    actionUpdated = Red.Event("ActionChanged", actionUpdateCheck),
}

return Events