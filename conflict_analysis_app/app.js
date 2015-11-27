var express = require('express');
var app = express();

app.set('views', './views');
app.set('view engine', 'jade');

app.get('/', function (req, res) {
  res.render('index', {
    title: 'Welcome'
  });
});

app.get('/map', function (req, res) {
  res.render('map', {
    title: 'Here be a map'
  });
});

var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root',
  database : 'gdelt'
});

connection.connect();

connection.query('select * from top_cities limit 1', function(err, rows, fields) {
  if (err) throw err;
  console.log('The solution is: ', rows[0]);
});

connection.end();

var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});
