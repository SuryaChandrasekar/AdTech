//Declaration

var http = require("http");
var express = require('express');
var app = express();
var mysql      = require('mysql');
var bodyParser = require('body-parser');

//Connecting to Database
var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database : 'adtech'
});

connection.connect(function(err) {
    if (err) { throw err }// internal log file capture
    console.log('You are now connected with mysql database...')
})

app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
    extended: true
}));

var server = app.listen(3000, "127.0.0.1", function () {

    var host = server.address().address
    var port = server.address().port

    console.log("Example app listening at http://%s:%s", host, port)

});

//Delivery event handling

app.post('/ads/delivery', function (req, res) {
    var params  = req.body;
    console.log(params);
// Checking passed value is null or not

    if(req.body.advertisementId == null || req.body.deliveryId == null || req.body.time == null ||
        req.body.browser == null || req.body.os == null || req.body.site == null ||
        req.body.advertisementId == "" || req.body.deliveryId == "" || req.body.time == "" ||
        req.body.browser == "" || req.body.os == "" || req.body.site == "")
    {
        res.status(500).json({ message: "Values should be Mandatory" });
    }
// Marking entry in Deliver table

    connection.query('INSERT INTO deliver (`ID`, `AdsID`, `DeliveryID`, `Time`, `Browser`, `OS`, `Site`) ' +
        'VALUES  (NULL,?,?,?,?,?,?)',
        [req.body.advertisementId,req.body.deliveryId,req.body.time,req.body.browser,req.body.os,req.body.site],
//   Handling error and pushing the details in log table

             function (error, results, fields) {
            if (error) {
                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                    'VALUES  (NULL,"Deliver" , current_timestamp() ,?,?)', [500,error.sqlMessage ]);
              res.status(500).json({ message: error.sqlMessage });
            } else {
               connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                    'VALUES  (NULL,"Deliver" , current_timestamp() ,?,"Deliver Successful")', [200]);
                res.status(200).json({ message: "Successful Deliver" });
            }

    });
});
//Click event handling

app.post('/ads/click', function (req, res) {
    var params  = req.body;
    console.log(params);
// Checking passed value is null or not

    if(req.body.deliveryId == null || req.body.deliveryId == "")
    {
        res.status(500).json({ message: "DeliveryID should be Mandatory for this Call" });
    }
 // Checking the passed DeliveryID exists in Deliver table

    connection.query('select ID from deliver where DeliveryID =?',req.body.deliveryId,
        function (error, results, fields) {
            if (error) {
                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                    'VALUES  (NULL,"Deliver" , current_timestamp() ,?,?)', [500, error.sqlMessage]);
                res.status(500).json({message: error.sqlMessage});
            } else {
                var len = results.length;
                  if (len == 0) {
                    connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                        'VALUES  (NULL,"Deliver" , current_timestamp() ,?,"never received the given delivery:?")', [404, req.body.deliveryId]);
                   res.status(404).json({message: "never received the given delivery:" + req.body.deliveryId});
                } else {
// Marking entry in click table

                    var ID = results[0]["ID"];
                    connection.query('INSERT INTO click (`ID`, `DeliveryID`, `ClickTime`) ' +
                        'VALUES  (NULL,?,current_timestamp())', ID,
                        function (error, results, fields) {
                            if (error) {
//   Handling error and pushing the details in log table

                                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                                    'VALUES  (NULL,"Click" , current_timestamp() ,?,?)', [500, error.sqlMessage]);
                               res.status(500).json({message: error.sqlMessage});
                            } else {
                                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                                    'VALUES  (NULL,"Click" , current_timestamp() ,?,"Click Successful")', [200]);
                                res.status(200).json({message: "Successful Click"});
                            }
                        }
                    );
                }
            }
        }
    )
});

//Install event handling

app.post('/ads/install', function (req, res) {
    var params = req.body;
    console.log(params);
// Checking passed value is null or not

    if(req.body.deliveryId == null || req.body.deliveryId == "")
    {
        res.status(500).json({ message: "DeliveryID should be Mandatory for this Call" });
    }
// Checking the passed DeliveryID exists in Deliver table
    connection.query('select C.ID from deliver D join click C on D.ID=C.DeliveryID where D.DeliveryID =?', req.body.deliveryId,
        function (error, results, fields) {
            if (error) {
                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                    'VALUES  (NULL,"Click" , current_timestamp() ,?,?)', [500, error.sqlMessage]);
                     res.status(500).json({message: error.sqlMessage});
            } else {
                var len = results.length;
                if (len == 0) {
                    connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                        'VALUES  (NULL,"Click" , current_timestamp() ,?,"never received the given click:?")', [404, req.body.clickId]);
                        res.status(404).json({message: "never received the given click:" + req.body.deliveryId});
                } else {
// Marking entry in Install table

                    var ID = results[0]["ID"];
                    connection.query('INSERT INTO install (`ID`, `ClickID`, `InstallTime`) ' +
                        'VALUES  (NULL,?,current_timestamp())', ID,
                        function (error, results, fields) {
                            if (error) {
//   Handling error and pushing the details in log table
                                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                                    'VALUES  (NULL,"Install" , current_timestamp() ,?,?)', [500, error.sqlMessage]);
                                 res.status(500).json({message: error.sqlMessage});}
                            else {
                                  connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                                    'VALUES  (NULL,"Install" , current_timestamp() ,?,"Install Successful")', [200]);
                                res.status(200).json({message: "Successful Install"});

                            }
                        }
                    );
                }
            }
        }
    )
});

//Statistics Data Event handling

app.get('/ads/statistics', function
    (req, res) {
// Checking passed value is null or not

    if(req.query.start == null || req.query.end==null || req.query.start == "" || req.query.end=="")
    {
        res.status(500).json({ message: "Date Values cannot be Empty" });
    }
    console.log(req.query.start);
    console.log(req.query.end);
    var str1 = "";
    var str2 = "";
//Verifying the Groupby Arguments are not null

    if(req.query.groupby != null) {

        var isarray = Array.isArray(req.query.groupby);
        if (isarray == true) {

            var arr = req.query.groupby;

            var i = 0;
            for (var grpby in arr) {
//Defining Groupby Value list to feeded with

                var arrgroupby = ["browser", "os", "site"];
                if(!arrgroupby.includes(arr[grpby].toLowerCase()))
                {
                    res.status(500).json({ message: "Incorrect filter selection" });
                }
                str1 += "M." + arr[grpby] + ",";
                if (i == arr.length - 1) {
                    str2 += "M." + arr[grpby];
                } else {
                    str2 += "M." + arr[grpby] + ",";
                    i++;
                }
            }
        } else {

            str1 = "M." + req.query.groupby + ",";
            str2 = "M." + req.query.groupby;
        }
    }
//Dynamic Query building on Groupby
    var qry = "select "+ str1 +" count(distinct od.ID) as deliver, " +
        "count(distinct oc.ID) as click, count(distinct oi.id) as install "+
    "from (select d.Browser, d.Site, d.OS, d.ID as deliverid, c.ID as clickid, i.ID as installid  "+
    "from  deliver d left join click c on d.ID = C.DeliveryId left join install i on c.ID = i.clickID) M "+
    "Left join deliver od on od.ID = M.deliverid and od.time between ? and ? "+
    "Left join click oc on oc.ID = M.clickid and oc.clicktime  between ? and ? "+
    "Left join install oi on oi.ID = M.installid and oi.installtime between ? and ? ";

    if(str2 != "")
        qry = qry + " group by "+ str2;
console.log(qry);
    connection.query(qry,
        [req.query.start, req.query.end, req.query.start, req.query.end, req.query.start, req.query.end],

        function (error, results, fields) {
//   Handling error and pushing the details in log table

            if (error) {
                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                    'VALUES  (NULL,"Statistics" , current_timestamp() ,?,?)', [500, error.sqlMessage]);
                             res.status(500).json({message: error.sqlMessage});
            } else {
                connection.query('INSERT INTO log (`ID`, `Action`,`Time`, `StatusCode`, `Message`) ' +
                    'VALUES  (NULL,"Statistics" , current_timestamp() ,?,"Statics loaded Successful")', [200]);
//Handling the results based on Groupby Condition
                var result;
                if(req.query.groupby !=null)
                {
                    result=results;
                }
                else {
                    result=results[0];
                }
                var jsonObj = {
                    "Interval": {
                        "start": req.query.start,
                        "end": req.query.end
                    },
                    "stats": result
                }
                res.status(200).json(jsonObj);
                  }
        }
    )
});

