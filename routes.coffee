voice = require "voice.js"


client = new voice.Client({
	email: "werewolftext@gmail.com",
	password: "werewolftexter"
})

sendText = (number, text, cb) ->
	client.sms({to: number, text: text}, (err, res, data) ->
		return cb(err) if err
		cb(null)
	)


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
				vars.players.push {number:''}
				i++
			req.session.vars = vars
		res.render 'phoneNumbers', {vars:req.session.vars}
	)
	app.post('/count/:playerCount', (req, res) ->
		return res.send 400 if req.body.number?.length isnt req.body.roll?.length
		rolls = req.body.roll
		for number in req.body.number
			randomNum = getRandomInt(0, rolls)
			text = rolls[randomNum]
			rolls.remove(randomNum)
			#sendText(number, text, (err) -> console.log err)
		res.send "Doesn't work yet. I can't test until I get a phone"
	)
Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
getRandomInt = (min, max) ->
	Math.floor Math.random() * (max - min + 1) + min
