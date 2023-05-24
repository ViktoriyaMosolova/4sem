const express = require('express')
const passport = require('passport')
const router =  express.Router()

const upload = require('../middleware/upload')
const controller = require('../controller/user')

router.post('/user/registry', controller.createUser) // http://localhost:3000/api/user/registry
router.post('/user/login', controller.login)  // http://localhost:3000/api/user/login

router.delete('/user/:id', controller.deleteUser)  // http://localhost:3000/api/user/id
router.get('/user', controller.getUser)  // http://localhost:3000/api/user
router.get('/userpost', controller.getUserPost)  // http://localhost:3000/api/user
router.patch('/user/changename', controller.updateUserName)  // http://localhost:3000/api/user/changename
router.patch('/user/changelogin', controller.updateUserLogin)  // http://localhost:3000/api/user/changelogin
router.patch('/user/changepassword', controller.updateUserPassword)  // http://localhost:3000/api/user/changepassword
router.patch('/user/changephoto',  upload.single('image'), controller.updateUserPhoto)  // http://localhost:3000/api/user/changephoto

module.exports = router