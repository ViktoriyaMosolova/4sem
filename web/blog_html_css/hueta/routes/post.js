const express = require('express')
const controller = require('../controller/post')
const router =  express.Router()

const upload = require('../middleware/upload')


router.post('/post', upload.single('image'), controller.createPost) // http://localhost:3000/api/post
router.get('/post', controller.getPostsByUser) // http://localhost:3000/api/post?id=1
router.get('/post/:id', controller.getPost) // http://localhost:3000/api/post?id=1
router.get('/posts', controller.getPosts) // http://localhost:3000/api/posts
router.delete('/posts/:id', controller.deletePost) // http://localhost:3000/api/posts
router.patch('/post/:id', controller.deleteImage) // http://localhost:3000/api/posts
router.put('/post', upload.single('image'), controller.editPost);

module.exports = router