const express = require('express');
const app = express();
const path = require('path');
const User = require('./client/models/User');

// Подключение к базе данных
const sequelize = require('./client/models/sequelize-config');
sequelize.authenticate()
  .then(() => {
    console.log('Connection to database has been established successfully.');
  })
  .catch((err) => {
    console.error('Unable to connect to the database:', err);
  });

// Разрешение доступа к статическим файлам
app.use(express.static(path.join(__dirname, '/client/public')));


app.get('/profile.html', (req, res) => {
  res.sendFile(__dirname + '/client/public/html/profile.hjs');
});

app.get('/newpost.html', (req, res) => {
  res.sendFile(__dirname + '/client/public/html/newpost.hjs');
});

app.get('/log.html', (req, res) => {
  res.sendFile(__dirname + '/client/public/html/log.hjs');
});

app.get('/main.html', (req, res) => {
  res.sendFile(__dirname + '/client/public/html/main.hjs');
});


// Получение данных из базы данных
app.get('/users', async (req, res) => {
  try 
  {
    const users = await User.findAll();
    res.json(users);
  } 
  catch (err) 
  {
    console.error('Error retrieving users:', err);
    res.status(500).send('Error retrieving users');
  }
});


// Запуск сервера
app.listen(3000, () => {
  console.log('Server is running on port 3000');
});



