app = angular.module('myapp', ['faye'])

app.factory 'Faye', ['$faye', ($faye) ->

  options = {
    endpoints: {
        websocket: 'http://ws.example.com/'
    },
    retry: 5
  }

  $faye "http://localhost:8000/bayeux", options, (client) ->
    client.disable('autodisconnect');
]

app.controller "TestCtrl", ($scope, $http, Faye) ->
  # Publish
  Faye.publish("/channel-1", {msg: "hello"})

  # Subscribe
  $scope.data = []
  Faye.subscribe "/channel-2", (msg) ->
    $scope.data.push msg

  # Get just once (using $q - promise)
  $scope.data = Faye.get("/channel-3")

