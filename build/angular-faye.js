(function() {
  angular.module("faye", []);

  angular.module("faye").factory("$faye", [
    "$q", "$rootScope", function($q, $rootScope) {
      return function(url, fun) {
        var client, scope;
        scope = $rootScope;
        client = new Faye.Client(url);
        if (typeof fun === "function") {
          fun(client);
        }
        return {
          client: client,
          publish: function(channel, data) {
            return this.client.publish(channel, data);
          },
          subscribe: function(channel, callback) {
            return this.client.subscribe(channel, function(data) {
              return scope.$apply(function() {
                return callback(data);
              });
            });
          },
          get: function(channel) {
            var deferred, sub;
            deferred = $q.defer();
            sub = this.client.subscribe(channel, function(data) {
              scope.$apply(function() {
                return deferred.resolve(data);
              });
              return sub.cancel();
            });
            return deferred.promise;
          }
        };
      };
    }
  ]);

}).call(this);
