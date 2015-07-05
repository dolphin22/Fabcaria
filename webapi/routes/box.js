var express = require('express'),
	router = express.Router(),
	Box = require('../models/box')

router.route('/')
        .post(function(req, res) {
                var box = new Box()
                box.rfidTag = req.body.rfidTag
                box.foodName = req.body.foodName
                box.weight = req.body.weight

                box.save(function(err) {
                        if(err) res.send(err)
                        res.json({ message: 'Box created' })
                })
        })
        .get(function(req, res) {
                Box.find(function(err, boxes) {
                        if(err) res.send(err)
                        res.json(boxes)
                })
        })

router.route('/:rfidTag')
        .get(function(req, res) {
                Box.find({rfidTag: req.params.rfidTag}, function(err, box) {
                        if(err) res.send(err)
                        res.json(box)
                })
        })
        .put(function(req, res) {
                Box.findOne({rfidTag: req.params.rfidTag}, function(err, box) {
                        if(err) res.send(err)
                        box.rfidTag = req.body.rfidTag
                        box.foodName = req.body.foodName
                        box.weight = req.body.weight

                        box.save(function(err){
                                if(err) res.send(err)
                                res.send({ message: 'Box updated' })
                        })
                })
        })
        .delete(function(req, res) {
                Box.remove({
                        rfidTag: req.params.rfidTag
                }, function(err, box){
                        if(err) res.send(err)
                        res.json({ message: 'Box deleted' })
                })
        })

module.exports = router
