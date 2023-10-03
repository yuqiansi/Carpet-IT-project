const express = require('express')

const allRouter = express.Router()

const allController = require('../controllers/allController')

allRouter.get('/', allController.getHome)

allRouter.get('/login', allController.getLogin)

allRouter.get('/login-error', allController.getLoginError)

allRouter.get('/aboutUs', allController.getAboutUs)

allRouter.get('/guide', allController.getGuide)

allRouter.get('/signUp-nameError', allController.getSignUpNameError)

allRouter.get('/signUp', allController.getSignUp)

allRouter.get('/changePassword', allController.getChangePassword)

allRouter.get('/changePassword-error', allController.getChangePasswordError)

allRouter.get('/report', allController.getReport)

allRouter.get('/lost', allController.getLost)

allRouter.get('/found', allController.getFound)

allRouter.get('/mypost', allController.getMypost)


module.exports = allRouter