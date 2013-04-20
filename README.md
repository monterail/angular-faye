# Angular.js + Faye example

[Download angular-faye.js](https://github.com/teamon/angular-faye/raw/master/public/js/angular-faye.js)

## Usage

### HTML

```html
<script type="text/javascript" src="/js/angular.min.js"></script>
<script type="text/javascript" src="/js/angular-faye.js">
<script type="text/javascript" src="http://localhost:9292/faye/client.js"></script>
<script type="text/javascript" src="/js/app.js"></script>
```

### JavaScript (app.js)

```js
var app = angular.module('myapp', ['faye']);

app.factory('Faye', ['$faye', function($faye) {
  return $faye("http://localhost:9292/faye"); // set faye url in one place
}]);

this.TestCtrl = function($scope, $http, Faye) {
  // Publish
  Faye.publish("/channel-1", {msg: "hello"});

  // Subscribe
  $scope.data = [];
  Faye.subscribe("/channel-2", function(msg) {
    $scope.data.push(msg);
  });

  // Get just once (using $q - promise)
  $scope.data = Faye.get("/channel-3");
};
```

### CoffeeScript (the same as above, just in coffee)

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



## Run example

```bash
$ bundle
$ bundle exec ruby app.rb

# In different shell
$ bundle exec ruby faye.rb
```




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
