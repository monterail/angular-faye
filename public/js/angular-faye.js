angular.module('faye', []);

angular.module('faye').factory('$faye', ['$q', function($q){
  return function(url){
    var client = new Faye.Client(url);
    return {
      publish: function(channel, data){
        client.publish(channel, data)
      },
      subscribe: function(channel, callback){
        client.subscribe(channel, callback)
      },
      get: function(channel){
        var deferred = $q.defer();
        client.subscribe(channel, function(data){
          deferred.resolve(data);
        });
        return deferred.promise;
      }
    };
  };
}]);
