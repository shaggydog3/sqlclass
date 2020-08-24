// looping in javascript
//for(i = 0; i < 500; i++) {
//    console.log("Hello World!");
//}
var faker = require('faker');
var mysql = require('mysql');
var express = require('express');
var bodyParser = require("body-parser");
var app = express();

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + "/public"));

var connection = mysql.createConnection({
    host: 'db',
    user: 'root',
    password: 'example',
    database: 'join_us'
});


/*var q = 'SELECT COUNT(*) AS total FROM users';
connection.query(q, function (error, results, fields) {
    if (error) throw error;
    console.log(results[0].total)
})*/

app.get("/", function(req, res){
    var q = 'SELECT COUNT(*) AS total FROM users';
    connection.query(q, function (error, results) {
        if (error) throw error;
        count = results[0].total;
        //res.send("The total number of users is: " + user_count);
        res.render("home", {data: count});
    });
});

app.post("/register", function(req, res){
    var person = {
        email: req.body.email
    };
    var q = 'INSERT INTO users SET ?';
    var end_result = connection.query(q, person, function (error, results, fields) {
        if (error) throw error;
        res.redirect("/");
    //    console.log(results);
     //   console.log(end_result.sql);
    });
});

var joke = "<strong>What do you call a dog that does magic tricks?</strong>  <em>A labracadabrador.</em>";

app.get("/joke", function(req, res){
    res.send(joke);
    console.log("Requested the joke route!");
});

app.get("/random", function(req, res){
    var random_number = Math.floor(Math.random() * 10) + 1;
    res.send("Your lucky number is " + random_number);
});

app.listen(8080, function(){
    console.log("Server running on 8080!");
});

//connection.end();

//console.log(faker.address.city());

// Getting count of users...
/*var q = 'SELECT COUNT(*) AS total FROM users';
connection.query(q, function (error, results, fields) {
    if (error) throw error;
    console.log(results[0].total)
})*/

// inserting a single user.
/*var q = 'INSERT INTO users (email) VALUES ("rusty_the_dog@gmail.com")';
connection.query(q, function (error, results, fields) {
    if (error) throw error;
    console.log(results)
})*/


// inserting a single faked user and created date
/*var person = {
    email: faker.internet.email(),
    created_at: faker.date.past()
};
var q = 'INSERT INTO users SET ?';
var end_result = connection.query(q, person, function (error, results, fields) {
    if (error) throw error;
    console.log(results);
});
connection.end();*/


// A function to generate and print an address and date.

/*function generateAddress() {
    console.log(faker.internet.email());
    console.log(faker.date.past());
}*/

/*
var data = [];
for(var i = 0; i < 500; i++){
    data.push([
        faker.internet.email(),
        faker.date.past()
    ]);
}

var q = 'INSERT INTO users (email, created_at) VALUES ?';

var end_result = connection.query(q, [data], function (err, results, fields) {
    console.log(err)
    console.log(results);
});

//generateAddress();
console.log(end_result.sql)*/
