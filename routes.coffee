module.exports = (app) ->
	app.get('/', (req, res) ->
		res.render 'playercount'
	)
	app.post('/', (req, res) ->
		return res.send 404 unless req.body.playerCount and not isNaN req.body.playerCount
		res.redirect '/count/' + req.body.playerCount
	)
	app.get('/count/:playerCount', (req, res) ->
		return res.send 501 if isNaN req.params.playerCount
		unless req.session.numbers and req.session.rolls
			i = 0
			vars={}
			vars.rolls = []
			vars.players = []
			while i < Number(req.params.playerCount)
				vars.rolls.push {name: ''}
				vars.players.push {number:'', provider:''}
		res.render 'phoneNumbers', vars
	)
