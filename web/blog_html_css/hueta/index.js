const express = require('express');
const passport = require('passport')
const path = require('path')
const postRoutes = require("./routes/post");
const userRoutes = require("./routes/user");
const commonPageRoutes = require("./routes/commonPage");
const cors = require("cors");
const { access } = require('fs');
// const { default: axios } = require("axios")
const jwt = require('jsonwebtoken')
const bodyParser = require('body-parser');

const app = express();

app.use(cors());
app.use('/uploads', express.static('uploads'))
app.use(express.urlencoded({extended: true}))

// Разбор тела запроса
app.use(bodyParser.json()); // для запросов с Content-Type: application/json
app.use(bodyParser.urlencoded({ extended: true })); // для запросов с Content-Type: application/x-www-form-urlencoded

app.use(express.json());
app.use(express.static('public'))

app.use('/api', userRoutes);
app.use('/api', postRoutes);
app.use('/', commonPageRoutes)

// Обработчик защищенного маршрута
// Обработчик защищенного маршрута
app.get('/api/user/protected-route', (req, res) => {
    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.substring(7);
      try {
        const decodedToken = jwt.verify(token, 'cat');
        // console.log(decodedToken); // Выводим декодированный токен в консоль
        // Токен действителен, возвращаем защищенные данные
        res.json({ message: 'Защищенные данные' });
      } catch(error) {
        // console.log(error); // Выводим сообщение об ошибке в консоль
        // Токен недействителен, возвращаем ошибку
        res.status(401).json({ message: 'Недействительный токен' });
      }
    } else {
      // Заголовок Authorization отсутствует, возвращаем ошибку
      res.status(401).json({ message: 'Токен не предоставлен' });
    }
  });

// Маршрут для страницы профиля
// app.get('/profile', (req, res) => {
//     res.sendFile(__dirname + '/public/html/profile.html');
// });

// // Маршрут для страницы создания нового поста
// app.get('/newpost', (req, res) => {
//     res.sendFile(__dirname + '/public/html/newpost.html');
// });

// // Маршрут для основной страницы приложения
// app.get('/main', (req, res) => {
//     res.sendFile(__dirname + '/public/html/main.html');
// });

// app.get('/registry', (req, res) => {
//     res.sendFile(__dirname + '/public/html/registry.html');
// });

// app.get('/login', (req, res) => {
//     res.sendFile(__dirname + '/public/html/log.html');
// });

// app.get('/login', (req, res) => {
//     res.sendFile(__dirname + '/public/html/login.html');
// });


require('./middleware/passport')(passport)
app.use(passport.initialize())


const PORT = process.env.PORT || 3000;
app.listen(PORT, ()=> console.log(`server started on port ${PORT}`))
