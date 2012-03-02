vows = require 'vows'
assert = require 'assert'
StockedItem = require '../src/stock'
	
vows
	.describe('stock')
	.addBatch
		'when creating a new stocked item':
			topic: -> new StockedItem('')
			
			'the item by default has expired': (topic) ->
				assert.ok topic.hasExpired()
				
			'the item by default has spoiled': (topic) ->
					assert.ok topic.hasSpoiled()
		
		'when fetching a string resource':
			topic: ->
				t = new StockedItem({uri:'http://www.ricksantorum.com/robots.txt',parser:'string'})
				t.fetch @callback
				return
			
			'a string should be returned': (error, results) ->
				assert.ifError error
				assert.isString results

		'when fetching a json-based resource':
			topic: ->
				t = new StockedItem('http://search.twitter.com/search.json?q=sugar')
				t.fetch @callback
				return
			
			'an object should be returned': (error, results) ->
				assert.ifError error
				assert.isObject results

		'when fetching a xml-based resource':
			topic: ->
				t = new StockedItem('http://search.twitter.com/search.atom?q=sugar')
				t.fetch @callback
				return

			'an object should be returned': (error, results) ->
				assert.ifError error
				assert.isObject results
				
	.export(module) 
