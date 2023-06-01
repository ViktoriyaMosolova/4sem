const express = require('express')
const controller = require('../controller/commonPage')
const router =  express.Router()
const upload = require('../middleware/upload')


router.get('/login', upload.single('image'), controller.log) // http://localhost:3000/login
router.get('/main', controller.main) // http://localhost:3000/main  passport.authenticate('jwt', { session: false }),
router.get('/newpost', controller.newpost) // http://localhost:3000/newpost
router.get('/profile',controller.profile) // http://localhost:3000/profile
router.get('/registry', controller.registry) // http://localhost:3000/registry


module.exports = router