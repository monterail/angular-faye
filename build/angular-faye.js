(function() {
  angular.module("faye", []);

  angular.module("faye").factory("$faye", [
    "$q", "$rootScope", function($q, $rootScope) {
      return function(url, options) {
        var client, deferred;
        if (options == null) {
          options = {};
        }
        deferred = $q.defer();
        client = new Faye.Client(url, options);
        deferred.resolve(client);
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
            var sub;
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
