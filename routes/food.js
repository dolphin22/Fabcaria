var express = require('express'),
	router = express.Router(),
	Food = require('../models/food')

router.route('/')
        .post(function(req, res) {
                var food = new Food()
                food.type = req.body.type
                food.name = req.body.name
                food.expire_in = req.body.expire_in

                food.save(function(err) {
                        if(err) res.send(err)
                        res.json({ message: 'Food created' })
                })
        })
        .get(function(req, res) {
                Food.find(function(err, foods) {
                        if(err) res.send(err)
                        res.json(foods)
                })
        })

router.route('/:food_name')
        .get(function(req, res) {
                Food.findOne(req.params.food_name, function(err, food) {
                        if(err) res.send(err)
                        res.json(food)
                })
        })
        .put(function(req, res) {
                Food.findById(req.params.food_id, function(err, food) {
                        if(err) res.send(err)
                        food.type = req.body.type
                        food.name = req.body.name
                        food.expire_in = req.body.expire_in

                        food.save(function(err){
                                if(err) res.send(err)
                                res.send({ message: 'Food updated' })
                        })
                })
        })
        .delete(function(req, res) {
                Food.remove({
                        _id: req.params.food_id
                }, function(err, food){
                        if(err) res.send(err)
                        res.json({ message: 'Food deleted' })
                })
        })

module.exports = router
