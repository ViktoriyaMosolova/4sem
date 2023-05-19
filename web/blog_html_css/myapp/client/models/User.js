const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('./sequelize-config');

const User = sequelize.define('User', {
  // Определение полей таблицы
  login: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
});

// Синхронизация модели с базой данных
User.sync()
  .then(() => {
    console.log('User model synced');
  })
  .catch((err) => {
    console.error('Error syncing User model:', err);
  });

module.exports = User;