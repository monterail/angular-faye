# Angular.js + Faye

Faye client wrapper for angular

## Example

### CoffeeScript

```coffee
app = angular.module('myapp', ['faye'])

app.factory 'Faye', ['$faye', ($faye) ->
  $faye("http://localhost:9292/faye") # set faye url in one place
]

@TestCtrl = ($scope, $http, Faye) ->
  # Publish
  Faye.publish("/channel-1", {msg: "hello"})

  # Subscribe
  $scope.data = []
  Faye.subscribe "/channel-2", (msg) ->
    $scope.data.push msg

  # Get just once (using $q - promise)
  $scope.data = Faye.get("/channel-3")
```


### Configure Faye client

```coffee
app.factory 'Faye', ['$faye', ($faye) ->
  $faye "http://localhost:9292/faye", (client) ->
    client.disable("websocket")
]
```

## Development

```bash
npm install
grunt
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
