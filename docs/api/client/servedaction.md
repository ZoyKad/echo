# ServedAction

ServedAction is the action that a client uses to replicate data to other players. It is created in the callback of [Client:RegisterAction()](./#registeraction-name-string-servedaction)

***

## Methods

### Start(infos: table)

Start the action with and broadcast the given infos

###

### Dispatch(eventName: string, infos: table)

Sends an update with the given event and infos

###

### End(infos: table)

Ends the action instance

{% hint style="warning" %}
The instance will be destroyed on the next frame after calling this method
{% endhint %}
