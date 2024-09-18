const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^[a-zA-Z0-9_.+]*[a-zA-Z][a-zA-Z0-9_.+]*@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
                return value.match(re);
            },
            message: "Enter a valid email address"
        }
    },
    password: {
        required: true,
        type: String,
        validate:{
            validator: (value)=>{
                return value.length>=6;
            }, 
            message:"password must be of 6 characters or more."
        }
    },
    address: {
        type:String,
        default: ''
    },
    type:{
        type:String,
        default:'user'
    }
});


module.exports= mongoose.model("User",userSchema);