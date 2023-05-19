const express = require('express')
const controller = require('../controller/commonPage')
const passport = require("passport");
const router =  express.Router()

const upload = require('../middleware/upload')

router.get('/login', upload.single('image'), controller.log) // http://localhost:3000/api/post
router.get('/main',passport.authenticate('jwt', { session: false }), controller.main) // http://localhost:3000/api/post?id=1
router.get('/newpost',passport.authenticate('jwt', { session: false }), controller.newpost) // http://localhost:3000/api/post
router.get('/profile',passport.authenticate('jwt', { session: false }), controller.profile) // http://localhost:3000/api/post?id=1
router.get('/registry', controller.registry) // http://localhost:3000/api/post

module.exports = router