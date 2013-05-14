angular.module('faye', []);

angular.module('faye').factory('$faye', ['$q', function($q){
  return function(url){
    var client = new Faye.Client(url);
    return {
      publish: function(channel, data){
        return client.publish(channel, data);
      },
      subscribe: function(channel, callback){
        return client.subscribe(channel, callback);
      },
      get: function(channel){
        var deferred = $q.defer();
        var sub = client.subscribe(channel, function(data){
          deferred.resolve(data);
          sub.cancel();
        });
        return deferred.promise;
      }
    };
  };
}]);
