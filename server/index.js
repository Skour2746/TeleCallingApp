
express = require('express');
const cors = require('cors');
const mongoose = require("mongoose");
const auth = require('./routes/auth');
const dash = require('./routes/dash');
const db= "mongodb://localhost:27017";
const Port = 3000;

const app = express();
app.use(dash);
app.use(express.json());
app.use(auth);
app.use(cors());

mongoose.connect(db, { useNewUrlParser: true, useUnifiedTopology: true }).then(()=>{
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
});

app.get("/nodemon", function (req, res) {
    console.log("Run NodeMon Website");
    res.send("NodeMon Website");
});

app.listen(Port, "0.0.0.0", function () {
    console.log("Server Started.....");
});

app.use(cors({
    origin: 'http://localhost:52767' // replace with your frontend domain
}));