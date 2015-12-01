(function() {
  var app;

  app = angular.module('myapp', ['faye']);

  app.factory('Faye', [
    '$faye', function($faye) {
      var options;
      options = {
        endpoints: {
          websocket: 'http://ws.example.com/'
        },
        retry: 5
      };
      return $faye("http://localhost:8000/bayeux", options, function(client) {
        return client.disable('autodisconnect');
      });
    }
  ]);

  app.controller("TestCtrl", function($scope, $http, Faye) {
    Faye.publish("/channel-1", {
      msg: "hello"
    });
    $scope.data = [];
    Faye.subscribe("/channel-2", function(msg) {
      return $scope.data.push(msg);
    });
    return $scope.data = Faye.get("/channel-3");
  });

}).call(this);
