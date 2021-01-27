var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: ''

});

connection.connect(function (err) {
    if (err) {
        throw err
    }// internal log file capture
    console.log('You are now connected with mysql database...')
//Creation of DB
    connection.query('Create Database NewDatabasename',//Database Name
        function (error, results, fields) {
            if (error) {
                console.log(error.sqlMessage);

            } else {
                console.log("Database Created")
            }
        });

    connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'NewDatabasename' // Database Reference
    });

//Creation of Tables
    connection.query('CREATE TABLE deliver (' +
        '  ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,' +
        '  AdsID int(11) NOT NULL,' +
        '  DeliveryID varchar(50) NOT NULL UNIQUE KEY,' +
        '  Time timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),' +
        '  Browser varchar(50) NOT NULL,' +
        '  OS varchar(50) NOT NULL,' +
        '  Site varchar(50) NOT NULL' +
        ') ',
        function (error, results, fields) {
            if (error) {
                console.log(error.sqlMessage);

            } else {
                console.log("Deliver Table Created");
            }
        });

    connection.query('CREATE TABLE click (' +
        '  ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,' +
        '  DeliveryID int(11) NOT NULL,' +
        '  ClickTime timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()\n' +
        ') ',
        function (error, results, fields) {
            if (error) {
                console.log(error.sqlMessage);

            } else {
                console.log("Click Table Created");
            }
        });

    connection.query('CREATE TABLE install (' +
        '  ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,' +
        '  ClickID int(11) NOT NULL,' +
        '  InstallTime timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()\n' +
        ') ',
        function (error, results, fields) {
            if (error) {
                console.log(error.sqlMessage);

            } else {
                console.log("Install Table Created");
            }
        });

    connection.query('CREATE TABLE log (' +
        '  ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,' +
        '  Action varchar(10) NOT NULL,' +
        '  Time timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),' +
        '  StatusCode int(11) NOT NULL,' +
        '  Message varchar(200) NOT NULL' +
        ') ',
        function (error, results, fields) {
            if (error) {
                console.log(error.sqlMessage);

            } else {
                console.log("Log Table Created");
            }
        });
});
