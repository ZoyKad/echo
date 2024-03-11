local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ActionManager = require(ReplicatedStorage.ActionManager)

local function throwABall(subAction: ActionManager.SubscribedAction, infos: any)
    local ball = Instance.new("Part")
    ball.Size = Vector3.new(1, 1, 1)
    ball:PivotTo(infos.location)
    ball.Anchored = true
    ball.CanCollide = true

    local function onUpdate(eventName: string, updateInfos: any)
        if eventName == "Throw" then
            ball:ApplyImpulse(updateInfos.direction)
        elseif eventName == "Explode" then
            ball.Color = Color3.new(1, 0, 0)
            ball.Size = Vector3.new(5, 5, 5)
            ball.Transparency = 1
        end
    end

    local function onEnd()
        ball:Destroy()
    end

    subAction.updated:Connect(onUpdate)
    subAction.ended:Connect(onEnd)
end

ActionManager:SubscribeToAction("ThrowABall", throwABall)