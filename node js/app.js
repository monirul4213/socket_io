const express = require("express");
var http = require("http");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);

//middlewre
app.use(express.json());
var clients = {};

io.on("connection", (socket) => {
  console.log("connetetd");
  console.log(socket.id, "has joined");
 

  socket.on('message', (msg) => {
    console.log('message: ' + msg);
    io.emit('message', msg);
  });



});

server.listen(port, "0.0.0.0", () => {
  console.log("server started");
});