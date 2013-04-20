app = angular.module('test', ['faye'])

app.factory 'Faye', ['$faye', ($faye) ->
  $faye("http://localhost:9292/faye")
]

@TestCtrl = ($scope, $http, Faye) ->

  $scope.foo = 1
  $scope.publishFoo = ->
    $http.post("/publish", {
      channel: "/test-channel-foo"
      data: {
        foo: $scope.foo++
        baz: "Hello"
      }
    })

  $scope.channelFoo = []
  Faye.subscribe "/test-channel-foo", (msg) ->
    $scope.channelFoo.push msg


  $scope.bar = 1
  $scope.publishBar = ->
    $http.post("/publish", {
      channel: "/test-channel-bar"
      data: {
        bar: $scope.bar++
        baz: "Hello"
      }
    })


  $scope.channelBar = Faye.get("/test-channel-bar")


