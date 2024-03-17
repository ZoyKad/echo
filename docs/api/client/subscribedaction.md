# SubscribedAction

SubscribedAction is an object created using [Echo:SubscribeToAction](https://app.gitbook.com/o/OdbeDW5ci9zOWzp092i7/s/v10PEnd3F5nmS4BCbqhI/\~/changes/1/api/client#subscribetoaction-name-string-callback-function-subscribedaction)

## Events

### Updated -> (eventName: string, infos: table)

This event is fired when an event is dispatched.

### Ended -> (infos: tables)

This event is fired when the action instance is ended.

{% hint style="warning" %}
The instance will be destroyed on the next frame after calling this method
{% endhint %}

