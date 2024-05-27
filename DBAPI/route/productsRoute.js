const express = require('express');

const router = express.Router();
const {getProducts,insertProduct,deletProducts}= require('../logic/functionsProduct');


router.get('/',getProducts);
router.post('/',insertProduct);
router.delete('/:id',deletProducts);

module.exports = router
