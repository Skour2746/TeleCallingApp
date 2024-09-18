const express = require('express');
const bcrypt = require('bcryptjs');
const User = require('../model/user');
const jwt = require("jsonwebtoken");
const { createConnection } = require("mongoose");
const authRouter = express.Router();
const auth= require('../midddleware/auth');

authRouter.post("/api/signup", async (req, res) => {

    try {
        const { name, email, password } = req.body;

        const exist = await User.findOne({ email });
        if (exist) {
            return res.status(400).json({ msg: "user already exist" });
        }
        const hashedPassword = await bcrypt.hash(password, 3);

        var user = new User({
            email,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    } catch (er) {
        res.status(500).json({ error: er.message });
    }
});


authRouter.post("/validateStamp", async (req, res) => {
    try {


        const token = req.header('stamp');
        if (!token) return res.json(false);
        const isValid = jwt.verify(stamp, 'secretKey');
        if (!isValid) return res.json(false);
        const user = await User.findOne(isValid.id);
        if (!User) return res.json(false);
        res.json(true);
    } catch (error) {
res.status(500).json({error: error.message});
    }
});



authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User doesn't exist." });
        }

        const isMatching = await bcrypt.compare(password, user.password);
        if (!isMatching) {
            return res.status(400).json({ msg: 'Incorrect Password' });
        }
        const stamp = jwt.sign({ id: user._id, }, "secretKey", { expiresIn: '1h' });
        res.json({stamp, user: { ...user._doc } });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

authRouter.get('/',auth, async (req,res)=>{
    const user= await User.findOne(req.user);
    res.json({...user._doc, stamp:req.stamp});
})


module.exports = authRouter;

