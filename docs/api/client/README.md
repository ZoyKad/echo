# 🕹️ Client

## Setup

***

You can call the client side using

```lua
local Echo = require(path.to.lib)
```

{% hint style="danger" %}
Calling the Client module from server will result in an error
{% endhint %}

## Methods

### RegisterAction(name: string): [ServedAction](servedaction.md)

Returns a new [ServedAction ](servedaction.md)with the given name

```lua
local throwABall = Echo.Client:RegisterAction("ThrowABall")
```

###

### SubscribeToAction(name: string, callback: function): [SubscribedAction](subscribedaction.md)

Call the callback when an action with the given name is started

The callback takes 2 parameters :

<table><thead><tr><th width="176">Argument</th><th width="166">Type</th><th>Description</th></tr></thead><tbody><tr><td>subscribedAction</td><td><a href="subscribedaction.md">SubscribedAction</a></td><td>An object containing all the infos about an action instance</td></tr><tr><td>Infos</td><td>table</td><td>Additional data shared by the serving client</td></tr></tbody></table>

```lua
Echo:SubscribeToAction("ThrowABall", function(subscribedAction: Echo.SubscribedAction, infos)
    print("Someone started to throw a ball")
end)
```
