const {Sequelize} = require("sequelize");

module.exports = new Sequelize('postgres://user:userpass@localhost:5432/testdb')
