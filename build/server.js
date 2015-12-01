var fs      = require('fs'),
    path    = require('path'),
    http    = require('http'),
    deflate = require('permessage-deflate'),
    faye    = require('../node_modules/faye/node/faye-node');

var SHARED_DIR = __dirname + '/..',
    PUBLIC_DIR = SHARED_DIR + '/public',

    bayeux     = new faye.NodeAdapter({mount: '/bayeux', timeout: 20}),
    port       = '8000'

bayeux.addWebsocketExtension(deflate);

var server = http.createServer();

bayeux.attach(server);
server.listen(Number(port));

bayeux.on('publish', function(clientId, channel, data){
  console.log('[PUBLISH] ' + clientId + ' # ' + channel + ' -> ' + data.msg);
});

bayeux.on('subscribe', function(clientId, channel) {
  console.log('[SUBSCRIBE] ' + clientId + ' -> ' + channel);
});

bayeux.on('unsubscribe', function(clientId, channel) {
  console.log('[UNSUBSCRIBE] ' + clientId + ' -> ' + channel);
});

bayeux.on('disconnect', function(clientId) {
  console.log('[DISCONNECT] ' + clientId);
});

console.log('Listening on ' + port);