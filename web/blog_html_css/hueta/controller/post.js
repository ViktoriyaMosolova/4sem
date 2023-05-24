const db = require("../db");
const moment = require("moment/moment");

module.exports.createPost = async function (req, res) {
    try {
        const newPost = await db.query('INSERT INTO post1 (title, image, content, user_id, date) values ($1, $2, $3, $4, $5) RETURNING *',
            [req.body.title, req.file ? req.file.path : '', req.body.content, req.body.userId, moment().format('DD.MM.YYYY HH:mm:ss')]
        )
        console.log('createPost')
        res.json(newPost.rows[0])
    }
    catch (e) {
        console.log({ message: e })
    }

}
module.exports.getPostsByUser = async function (req, res) {
    const id = req.query.id
    const posts = await db.query('select * from post1 where user_id = $1', [id])
    console.log('getPostByUser')
    res.json(posts.rows)
}
module.exports.getPosts = async function (req, res) {
    const posts = await db.query('SELECT * FROM post1 ORDER BY id')
    console.log('getUsers')
    res.json(posts.rows)
}

module.exports.getPost = async function (req, res) {
    const id = req.params.id
    const post = await db.query('SELECT * FROM post1 WHERE id = $1', [id])
    console.log('getUsers')
    // console.log(id)
    res.json(post.rows[0])
}

module.exports.deletePost = async function (req, res) {
    const id = req.params.id
    const post = await db.query('DELETE FROM post1 where id = $1', [id])
    console.log('deletePost')
    res.json(post.rows[0])
}

module.exports.deleteImage = async function (req, res) {
    const id = req.params.id
    const image = ''
    const post = await db.query('UPDATE post1 SET image = $2 WHERE id = $1', [id, image])
    console.log('deleteimage')
    res.json(post.rows[0])
}

module.exports.editPost = async function (req, res) {
    try {
        const image = req.file ? req.file.path : '';
        const updatedPost = await db.query(
            'UPDATE post1 SET title = $1, content = $2, image = $3 WHERE id = $4 RETURNING *',
            [req.body.title, req.body.content, image, req.body.id]
        );
        console.log('editPost');
        res.json(updatedPost.rows[0]);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Ошибка сервера' });
    }
    console.log(req.file, req.body.title, req.body.content, req.body.id);
};
