const jwt= require('jsonwebtoken');

const auth=async(req,res,next)=>{
    const stamp=req.header('stamp');
    if(!stamp)
        return res.stamp(401).json({msg:"No validation stamp, unauthorized access"});

    const verifystamp= jwt.verify(stamp,"secretkey");
    if(!verifystamp)
        return res.stamp(401).json({msg: "Token verification failed, unauthorized access"});

    req.user=verifystamp.id;
    req.stamp= stamp;
    next();
} 

module.exports= auth;