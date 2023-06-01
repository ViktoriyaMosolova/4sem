const database = require("./database");
const {DataTypes} = require("sequelize");
const todoModel = require("./todoModel");

const userModel = database.define('User', {
    username: {
        type: DataTypes.STRING,
        allowNull: false
    },
    mail: {
        type: DataTypes.STRING,
        allowNull: false
    },
    password: {
        type: DataTypes.STRING,
        allowNull: false
    },
})


userModel.hasMany(todoModel, {as: 'todos', foreignKey: 'userId'})
todoModel.belongsTo(userModel, {foreignKey: 'userId'})

module.exports = userModel