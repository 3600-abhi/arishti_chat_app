
const mongoose = require('mongoose');
const mongooseURI = "mongodb+srv://abhishek:abhishek@cluster0.wtesxiv.mongodb.net/chat_app?retryWrites=true&w=majority";

const connectToMongo = () => {
     mongoose.connect(mongooseURI, () => {
        console.log('connected to Mongo successfully');
    });
}

module.exports = connectToMongo;