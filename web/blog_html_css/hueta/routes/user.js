const express = require('express')
const passport = require('passport')
const router =  express.Router()

const upload = require('../middleware/upload')
const controller = require('../controller/user')

router.post('/user/register', controller.createUser) // http://localhost:3000/api/user/register
router.post('/user/login', controller.login)  // http://localhost:3000/api/user/login

router.delete('/user/:id', passport.authenticate('jwt', { session: false }), controller.deleteUser)  // http://localhost:3000/api/user/id
router.get('/user', passport.authenticate('jwt', { session: false }), controller.getUsers)  // http://localhost:3000/api/user
router.patch('/user/changename', passport.authenticate('jwt', { session: false }), controller.updateUserName)  // http://localhost:3000/api/user/changename
router.patch('/user/changelogin', passport.authenticate('jwt', { session: false }), controller.updateUserLogin)  // http://localhost:3000/api/user/changelogin
router.patch('/user/changepassword', passport.authenticate('jwt', { session: false }), controller.updateUserPassword)  // http://localhost:3000/api/user/changepassword
router.patch('/user/changephoto', passport.authenticate('jwt', { session: false }), upload.single('image'), controller.updateUserPhoto)  // http://localhost:3000/api/user/changephoto

module.exports = router