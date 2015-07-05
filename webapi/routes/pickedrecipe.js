var express = require('express'),
	router = express.Router(),
	async = require('async'),
	Box = require('../models/box'),
	Recipe = require('../models/recipe')	

router.route('/')
        .post(function(req, res) {
		Recipe.findOne({ name: req.body.recipeName }, function(err, recipe) {
			if(err) res.send(err)
			ingredients = JSON.stringify(eval("(" + recipe['ingredients'] + ")"))
			jIngredients = JSON.parse(ingredients)

			async.each(jIngredients, function(ingredient, callback) {
//console.log(ingredient)
//	console.log(jIngredients)
	Box.findOne({name: ingredient.name},function(err,box) {
		if(err) res.send(err)
		if(box && (box.weight >= ingredient.weight)) ingredient.missing = 0
		else ingredient.missing = "1"
	})
	console.log(ingredient)
}, function(err) {
	if(err) res.send(err)
})
res.send(jIngredients)

	})
	})
module.exports = router
