// to run the backend :- nodemon start index.js
const connectToMongo = require('./db');
const express = require('express')
const cors = require('cors')
const app = express()
const port = 5000
app.use(cors());

connectToMongo();

const server = app.listen(port, () => {
    console.log("Chat app listening at http://localhost:5000");
});

const io = require('socket.io')(server)

io.on('connection', (socket) => {
    console.log('socket io connected successfully', socket.id);
    socket.on('disconnect', () => {
        console.log('disconnected', socket.id);
    });

    socket.on('message', (message) => {
        console.log('node js side ', message);
        socket.broadcast.emit('message-recieve', message);
    });


});




app.get('/', (req, res) => {
    res.send({'From Nodejs' : 'Hello Abhi i am nodejs'});
});

