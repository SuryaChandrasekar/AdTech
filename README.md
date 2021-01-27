# AdTech
Simple implementation of an AdTech web service that tracks the ads that are being delivered through their lifecycle and generates some simple statistics.

## Installation
node: v14.15.4 <br>
mysql: v2.18.1 (Please Install XAMPP) <br>
postman: Latest Version <br>

## Usage 

Step 1: Using XAMPP, Start mysql and Apache. <br>
Step 2: Access the code from git by running out 'git clone https://github.com/SuryaChandrasekar/AdTech.git'. <br>
Step 3: Move to the cloned directory and run 'npm install'. <br>
Step 4: run 'node index'. <br>
Step 5: Open postman and drive the test on required request in Adtech collection with input parameter mentiones as per api document shared. <br>
        POST/ads/deliver <br>
        POST/ads/click <br>
        POST/ads/install <br>
        GET/ads/statistics <br>

## Contributing
Incase of new DB creation, open createDB.js and update the name of DB to be created in mysql Create Database "NewDatabase Name" @ //Database Name, 
Also update the "New Database Name" @ //Database Reference for new table creation.
