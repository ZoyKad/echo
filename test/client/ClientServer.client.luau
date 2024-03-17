local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Echo = require(ReplicatedStorage.Packages.Echo)

local echoClient = Echo.Client

while true do
    local throwABallAction = echoClient:RegisterAction("ThrowABall")
    
    task.wait(5)

    throwABallAction:Start({location = CFrame.new(0, 5, 0)})

    task.wait(1)

    throwABallAction:Dispatch("Throw", {direction = Vector3.new(0, 1, 0)})

    task.wait(3)

    throwABallAction:Dispatch("Explode")

    task.wait(1)

    throwABallAction:End()
end