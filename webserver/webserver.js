var path = require("path");
var express = require("express");
var app = express();
app.use(express.static(path.join(process.cwd(), "www_root")));
app.listen(6080); // http://127.0.0.1:6080/cub_bundle

