const database = require('./models/database')
const userModel = require('./models/userModel')
const todoModel = require('./models/todoModel')
const express = require('express')
const server = express()

const port = 3000


const handleRoute = (req,res) => {
    return userCreateService(req.body)
}



server.get()
server.post()
server.post('/update', handleRoute)
server.post()



server.listen(port, () => {
    console.log(`Server running on ${port} port!`)
})















const main = async () => {
    // проверка подключения к бд
    try {
        await database.authenticate()
        console.log('Database connection established!')
        await database.sync()
    } catch(e) {
        console.log('Database connection error!')
        console.log(e)
    }





    // создание записи в бд
    // const user = await userModel.create({
    //     username: 'Arion',
    //     mail: 'am@mail.ru',
    //     password: '1234'
    // })
    // console.log(user)


    // поиск пользователя
    // const user = await userModel.findOne({
    //     where: {
    //         username: 'Arion'
    //     }
    // })
    // console.log(user)


    // удаление пользователя
    // await user.destroy()


    // создание со вхождением
    // const todo = await todoModel.create({
    //     task: 'Сварить пельменей',
    //     userId: 1
    // })


    // поиск со вхождением
    // const userWithTodos = await userModel.findOne({
    //     include: [{
    //         model: todoModel,
    //         as: 'todos'
    //     }]
    // })
    // console.log(userWithTodos.todos)
    // console.log(JSON.stringify(userWithTodos.todos, null, 2))
}


main()














