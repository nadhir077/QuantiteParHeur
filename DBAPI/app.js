const express = require('express');
const productsRoute= require('./route/productsRoute');
const app =express();
const mongoose=require('mongoose');
const cors=require('cors');

app.use(express.urlencoded({ extended: true }),express.json())
app.use(cors());
mongoose.connect('mongodb+srv://tunidex2023:nadhir1983@cluster0.xabyhro.mongodb.net/PRODUCTS?retryWrites=true&w=majority&appName=Cluster0',{
    useNewUrlParser:true,
    useUnifiedTopology:true
});

const connection = mongoose.connection;
connection.on('connected',()=>{
    console.log('connected whith cloud');
})
connection.on('error',()=>{
    console.log('error whith cloud');
})
var port =process.env.PORT || 8080;

app.use('/product',productsRoute);

app.listen(port,()=>{
    console.log("server is working at port "+port);
})

module.exports = app;