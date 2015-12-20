var express = require('express');
var app = express();
var fs = require('fs');
var moment = require('moment');
var momentRange = require('moment-range');

app.set('view engine', 'jade');
app.use(express.static('public'));

app.set('views', './views');
app.set('view engine', 'jade');

var mysql      = require('mysql');
var connection = mysql.createConnection(process.env.CLEARDB_DATABASE_URL);

connection.connect();

var start = new Date(2013, 6, 1);
var end = new Date(2015, 11, 6);
var range = moment.range(start, end);

range.by('days', function(moment) {
  var sqldate = moment.format('YYYYMMDD')
  var filedate = moment.format('YYYY-MM-DD')
  connection.query('select * from city_day_event_counts_plus where SQLDATE = ' + sqldate, function(err, rows, fields) {
    if (err) throw err;
    fs.writeFile('public/javascripts/events/' + filedate + '.json', JSON.stringify(rows), function (err) {
      if (err) throw err;
      console.log(filedate + ' saved!');
    });
  });
});

connection.end();

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

app.set('port', (process.env.PORT || 5000));

//For avoidong Heroku $PORT error
app.get('/', function(request, response) {
    var result = 'App is running'
    response.send(result);
}).listen(app.get('port'), function() {
    console.log('App is running, server is listening on port ', app.get('port'));
});
