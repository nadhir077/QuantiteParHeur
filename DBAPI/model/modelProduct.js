const mongoose=require('mongoose');
const products = new mongoose.Schema({
    refProduit : String,
    operation : String
});

module.exports = mongoose.model('PRODUCTS',products)