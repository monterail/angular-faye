angular.module "faye", []

angular.module("faye").factory "$faye", ["$q", "$rootScope", ($q, $rootScope) ->
  (url, fun) ->
    scope = $rootScope
    client = new Faye.Client(url)
    fun?(client)


    client: client
    publish: (channel, data) ->
      @client.publish channel, data

    subscribe: (channel, callback) ->
      @client.subscribe channel, (data) ->
        scope.$apply ->
          callback(data)

    get: (channel) ->
      deferred = $q.defer()
      sub = @client.subscribe(channel, (data) ->
        scope.$apply ->
          deferred.resolve data
        sub.cancel()
      )
      deferred.promise
]
