var express = require('express');

var app = express();

app.set('view engine', 'jade');
app.use(express.static('public'));

app.set('views', './views');
app.set('view engine', 'jade');

app.get('/', function (req, res) {
  res.render('index', {
    title: 'Welcome'
  });
});

app.get('/map', function (req, res) {
  res.render('map');
});

app.get('/summary', function (req, res) {
  res.render('summary');
});

app.get('/analysis', function (req, res) {
  res.render('analysis');
});

app.get('/conclusions', function (req, res) {
  res.render('conclusions');
});

app.get('/about', function (req, res) {
  res.render('about');
});

// var mysql      = require('mysql');
// var connection = mysql.createConnection({
//   host     : 'localhost',
//   user     : 'root',
//   password : 'root',
//   database : 'gdelt'
// });

// connection.connect();

// // connection.query('select * from top_cities limit 1', function(err, rows, fields) {
// //   if (err) throw err;
// //   console.log('The solution is: ', rows[0]);
// // });

// connection.end();

app.set('port', (process.env.PORT || 5000));

//For avoidong Heroku $PORT error
app.get('/', function(request, response) {
    var result = 'App is running'
    response.send(result);
}).listen(app.get('port'), function() {
    console.log('App is running, server is listening on port ', app.get('port'));
});
