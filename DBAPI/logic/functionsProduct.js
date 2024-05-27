const PRODUCTS=require('../model/modelProduct');
module.exports = {
    getProducts:async(req,res,next)=> {
        
        const product = await PRODUCTS.find();
        res.json({
            result : product.map(res => {
                return {
                    id : res.id,
                    refProduit : res.refProduit,
                    operation : res.operation
                }
            })
        })
    },

    insertProduct : async (req, res)=>{
        if (!req.body.refProduit) {
            return res.status(400).json({ message: "refProduit is missing in the request body" });
        }
        const product = await new PRODUCTS({
            refProduit : req.body.refProduit, 
            operation : req.body.operation,
        }).save();
        res.json({"message":"Inserted succesfully",
            id :product.id,
            refProduit : product.refProduit
        })
    },
    deletProducts: async(req,res,next)=> {
        
        const id= req.params.id;
        const del =await PRODUCTS.findByIdAndDelete(id);
        res.json({"delete":del});
        
    },
}