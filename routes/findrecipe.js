var express = require('express'),
	router = express.Router(),
	Recipe = require('../models/recipe')	

router.route('/')
        .post(function(req, res) {
		Recipe.find({ $text: { $search: req.body.foodName }}, function(err, recipes) {
			if(err) res.send(err)
			res.send(recipes)	
		})
        })

module.exports = router
