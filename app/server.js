var express = require('express');
var exphbs  = require('express-handlebars');
var app = express();
var os = require("os");
var morgan  = require('morgan');
var pjson = require('./package.json')

app.engine('handlebars', exphbs({defaultLayout: 'main'}));
app.set('view engine', 'handlebars');
app.use(express.static('static'));
app.use(morgan('combined'));

// Configuration
var port = process.env.PORT || 8080;
var message = process.env.MESSAGE || "Pod version:";

app.get('/', function (req, res) {
    res.render('home', {
      message: message,
      platform: os.type(),
      release: os.release(),
      hostName: os.hostname(),
      Version: pjson.version
    });
});

// Set up listener
app.listen(port, function () {
  console.log("Listening on: http://%s:%s", os.hostname(), port);
});