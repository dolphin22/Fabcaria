var express = require('express'),
	router = express.Router(),
	Recipe = require('../models/recipe')

router.route('/')
        .post(function(req, res) {
                var recipe = new Recipe()
                recipe.name = req.body.name
		recipe.imageurl = req.body.imageurl
                recipe.ingredients = req.body.ingredients

                recipe.save(function(err) {
                        if(err) res.send(err)
                        res.json({ message: 'Recipe created' })
                })
        })
        .get(function(req, res) {
                Recipe.find(function(err, recipes) {
                        if(err) res.send(err)
                        res.json(recipes)
                })
        })

router.route('/:recipe_id')
        .get(function(req, res) {
                Recipe.findById(req.params.recipe_id, function(err, recipe) {
                        if(err) res.send(err)
                        res.json(recipe)
                })
        })
        .put(function(req, res) {
                Recipe.findById(req.params.recipe_id, function(err, recipe) {
                        if(err) res.send(err)
                        recipe.name = req.body.name
                        recipe.imageurl = req.body.imageurl
                        recipe.ingredients = req.body.ingredients

                        recipe.save(function(err){
                                if(err) res.send(err)
                                res.send({ message: 'Recipe updated' })
                        })
                })
        })
        .delete(function(req, res) {
                Recipe.remove({
                        _id: req.params.recipe_id
                }, function(err, recipe){
                        if(err) res.send(err)
                        res.json({ message: 'Recipe deleted' })
                })
        })

module.exports = router
