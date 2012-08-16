Flume is a tool for standardizing logging in express-style servers. We use this tool to make sure all our production logs are stored in a similar format, and in a known location.

## Usage

   var express = require("express");
   var app = express();
   var flume = require("flume");
   flume(app, {env: app.env});
   app.listen(1234);
   # errors & access requests will be logged
