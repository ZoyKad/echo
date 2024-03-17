# ServedAction

ServedAction are the action that the client uses to transmit data to other players

## Methods

### Start(infos: table)

Start the action with and broadcast the given infos

### Dispatch(eventName: string, infos: table)

Sends an update with the given event and infos

### End(infos: table)

Ends the action instance

{% hint style="warning" %}
The instance will be destroyed on the next frame after calling this method
{% endhint %}
