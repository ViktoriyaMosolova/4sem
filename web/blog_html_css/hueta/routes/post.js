const express = require('express')
const controller = require('../controller/post')
const passport = require("passport");
const router =  express.Router()

const upload = require('../middleware/upload')


router.post('/post', passport.authenticate('jwt', { session: false }), upload.single('image'), controller.createPost) // http://localhost:3000/api/post
router.get('/post',passport.authenticate('jwt', { session: false }), controller.getPostsByUser) // http://localhost:3000/api/post?id=1
router.get('/posts',passport.authenticate('jwt', { session: false }), controller.getPosts) // http://localhost:3000/api/post

module.exports = router