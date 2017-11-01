angular.module "faye", []

angular.module("faye").factory "$faye", ["$q", "$rootScope", "$timeout", ($q, $rootScope, $timeout) ->
  (url, modifiers, fun) ->
    scope = $rootScope
    client = new Faye.Client(url, modifiers)
    fun?(client)


    client: client
    publish: (channel, data) ->
      @client.publish channel, data

    subscribe: (channel, callback) ->
      @client.subscribe channel, (data) ->
        $timeout ->
          callback(data)

    get: (channel) ->
      deferred = $q.defer()
      sub = @client.subscribe(channel, (data) ->
        $timeout ->
          deferred.resolve data
        sub.cancel()
      )
      deferred.promise
]
