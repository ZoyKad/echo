local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ActionManager = require(ReplicatedStorage.ActionManager)


local throwABallAction = ActionManager:RegisterAction("ThrowABall")

while true do
    task.wait(5000)

    throwABallAction:Start({location = CFrame.new()})

    task.wait(1)

    throwABallAction:Dispatch("Throw", {direction = Vector3.new(0, 0, 0)})

    task.wait(3)

    throwABallAction:Dispatch("Explode")

    task.wait(1)

    throwABallAction:End()
end