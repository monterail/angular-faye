(function() {
  angular.module("faye", []);

  angular.module("faye").factory("$faye", [
    "$q", "$rootScope", "$timeout", function($q, $rootScope, $timeout) {
      return function(url, modifiers, fun) {
        var client, scope;
        scope = $rootScope;
        client = new Faye.Client(url, modifiers);
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
              return $timeout(function() {
                return callback(data);
              });
            });
          },
          get: function(channel) {
            var deferred, sub;
            deferred = $q.defer();
            sub = this.client.subscribe(channel, function(data) {
              $timeout(function() {
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
