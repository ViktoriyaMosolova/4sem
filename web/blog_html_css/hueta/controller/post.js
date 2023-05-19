const db = require("../db");
const moment = require("moment/moment");

module.exports.createPost = async function (req, res){
    try{
        const newPost = await db.query('INSERT INTO post1 (title, image, content, user_id, date) values ($1, $2, $3, $4, $5) RETURNING *',
            [req.body.title, req.file ? req.file.path : '', req.body.content, req.body.userId, moment().format('DD.MM.YYYY HH:mm:ss')]
        )
        console.log('createPost')
        res.json(newPost.rows[0])
    }
    catch (e){
        console.log({message: e})
    }

}
module.exports.getPostsByUser = async function (req, res){
    const id = req.query.id
    const posts = await db.query('select * from post1 where user_id = $1', [id])
    console.log('getPostByUser')
    res.json(posts.rows)
}
module.exports.getPosts = async function(req, res){
    const posts = await db.query('SELECT * FROM post1')
    console.log('getUsers')
    res.json(posts.rows)
}
