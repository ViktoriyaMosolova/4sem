const express = require('express');
const passport = require('passport')
const path = require('path')
const postRoutes = require("./routes/post");
const userRoutes = require("./routes/user");
const commonPageRoutes = require("./routes/commonPage");
const cors = require("cors");

const app = express();

// app.use(express.static('public'))

app.use(cors());
app.use('/uploads', express.static('uploads'))
app.use(express.urlencoded({extended: true}))
app.use(express.json());
app.use(express.static('public'))
app.use('/api', userRoutes);
app.use('/api', postRoutes);
app.use('/', commonPageRoutes)

require('./middleware/passport')(passport)
app.use(passport.initialize())


const PORT = process.env.PORT || 3000;
app.listen(PORT, ()=> console.log(`server started on port ${PORT}`))
