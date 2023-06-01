const database = require("./database");
const {DataTypes} = require("sequelize");

module.exports = database.define('Todo', {
    task: {
        type: DataTypes.STRING,
        allowNull: false
    }
})