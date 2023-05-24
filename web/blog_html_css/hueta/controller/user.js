const bcrypt = require('bcryptjs')
const db = require('../db')
const jwt = require('jsonwebtoken')

module.exports.createUser = async function (req, res) {
    const candidate = await db.query(
        'SELECT * FROM person1 WHERE login = $1',
        [req.body.login]
    );
    if (candidate.rows.length > 0) {
        res.status(409).json({
            message: 'This user already exists',
        });
    } else {
        const salt = bcrypt.genSaltSync(10)
        const password = req.body.password
        const newPerson = await db.query(
            'INSERT INTO person1 (name, login, password, photo) VALUES ($1, $2, $3, $4) RETURNING *',
            [req.body.name, req.body.login, bcrypt.hashSync(password, salt), null]
        );
        console.log('createUser');
        res.json(newPerson.rows[0]);
    }
};

// app.get('/', function (req, res) {
//     res.render('index', { title: 'Hey', message: 'Hello there!'});
// });

// module.exports.getUsers = async function(req, res){
//     const users = await db.query('SELECT * FROM person1')
//     console.log('getUsers')
//     res.json({message: users.rows})
// }

module.exports.getUser = async function (req, res) {
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'cat');
    const userId = decodedToken.id;
    const user = await db.query('SELECT * FROM person1 WHERE id = $1', [userId])
    // console.log('getUser', 'userId:',  user.rows[0]);
    res.json(user.rows[0]);
}

module.exports.getUserPost = async function (req, res) {
    const id = req.query.id
    const user = await db.query('SELECT * FROM person1 WHERE id = $1', [id])
    // console.log(user.rows[0]);
    res.json(user.rows[0]);
}

module.exports.login = async function (req, res) {
    const candidate = await db.query(
        'SELECT * FROM person1 WHERE login = $1',
        [req.body.login]
    )
    if (candidate.rows.length > 0) {
        const passwordResult = bcrypt.compareSync(req.body.password, candidate.rows[0].password)
        if (passwordResult) {
            const token = jwt.sign({
                id: candidate.rows[0].id,
                login: candidate.rows[0].login
            }, 'cat', { expiresIn: 60 * 60 * 60 })
            res.status(200).json({
                token: 'Bearer ' + token
            });

        } else {
            res.status(401).json({
                message: 'Пароли не совпадают',
            });
        }
    } else {
        res.status(404).json({
            message: 'Логины не совпадают',
        });
    }
}

// module.exports.updateUser = async function(req, res){
//         const {id, name, surname} = req.body
//         const user =  await db.query('UPDATE person set name = $1, surname = $2 where id = $3 RETURNING *', [name, surname, id])
//         console.log('updateUser')
//         res.json(user.rows[0])
// }

module.exports.updateUserName = async function (req, res) {
    const { id, name } = req.body;
    const user = await db.query('UPDATE person1 SET name = $1 WHERE id = $2 RETURNING *', [name, id]
    );
    console.log('updateUserName');
    // console.log(user.rows[0]);
    res.json(user.rows[0]);
};

module.exports.updateUserLogin = async function (req, res) {
    const { id, login } = req.body;

    // Проверяем, есть ли уже пользователь с таким логином
    const existingUser = await db.query('SELECT * FROM person1 WHERE login = $1', [login]);
    if (existingUser.rows.length > 0) {
        return res.status(400).json({ message: 'Пользователь с таким логином уже существует' });
    }

    // Обновляем логин пользователя
    const user = await db.query('UPDATE person1 SET login = $1 WHERE id = $2 RETURNING *', [login, id]);

    console.log('updateUserLogin');
    res.json(user.rows[0]);
};

module.exports.updateUserPassword = async function (req, res) {
    const { id, password } = req.body;
    const user = await db.query('UPDATE person1 SET password = $1 WHERE id = $2 RETURNING *', [bcrypt.hashSync(password, bcrypt.genSaltSync(10)), id]
    );
    console.log('updateUserPassword');
    // console.log(user.rows[0]);
    res.json(user.rows[0]);
};

module.exports.updateUserPhoto = async function (req, res) {
    const { id } = req.body;
    const ph = req.file ? req.file.path : null
    const user = await db.query('UPDATE person1 SET photo = $1 WHERE id = $2 RETURNING *', [ph, id]);

    console.log('updateUserPhoto');
    // console.log(req.body);
    // console.log(req.file.path);

    res.json(user.rows[0]);
};

// module.exports.deleteUser = async function (req, res) {
//     const id = req.params.id
//     const user = await db.query('DELETE FROM person1 where id = $1', [id])
//     console.log('deleteUser')
//     // console.log(id);
//     res.json(user.rows[0])
// }


module.exports.deleteUser = async function (req, res) {
    const id = req.params.id;
    try {
        await db.query('BEGIN');
        await db.query('DELETE FROM post1 WHERE user_id = $1', [id]);
        const result = await db.query('DELETE FROM person1 WHERE id = $1 RETURNING *', [id]);
        await db.query('COMMIT');
        console.log(`User with id ${id} and all their posts have been deleted.`);
        res.json(result.rows[0]);
    } catch (error) {
        await db.query('ROLLBACK');
        console.error(`Error while deleting user with id ${id}: ${error}`);
        res.status(500).json({ error: 'Internal server error' });
    }
};