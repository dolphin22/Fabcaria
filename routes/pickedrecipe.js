var express = require('express'),
	router = express.Router(),
	Box = require('../models/box'),
	Recipe = require('../models/recipe')	

router.route('/')
        .post(function(req, res) {
		Recipe.findOne({ name: req.body.recipeName }, function(err, recipe) {
			if(err) res.send(err)
			res.send(recipe)
		})
	})

module.exports = router
