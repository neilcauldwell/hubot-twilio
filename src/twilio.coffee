Robot   = require("hubot").robot()
Adapter = require("hubot").adapter()

HTTP    = require "http"
QS      = require "querystring"

class Twilio extends Adapter
  constructor: (robot) ->
    @sid   = process.env.HUBOT_SMS_SID
    @token = process.env.HUBOT_SMS_TOKEN
    @from  = process.env.HUBOT_SMS_FROM
    @robot = robot
    super robot

  send: (user, strings...) ->
    message = strings.join "\n"

    @send_sms message, user.id, (err, body) ->
      if err or not body?
        console.log "Error sending reply SMS: #{err}"
      else
        console.log "Sending reply SMS: #{message} to #{user.id}"

  reply: (user, strings...) ->
    @send user, str for str in strings

  respond: (regex, callback) ->
    @hear regex, callback

  run: ->
    @robot.router.get "/hubot/sms", (request, response) =>
      payload = QS.parse(request.url)

      if payload.Body? and payload.From?
        console.log "Received SMS: #{payload.Body} from #{payload.From}"
        @receive_sms(payload.Body, payload.From)

      response.writeHead 200, 'Content-Type': 'text/plain'
      response.end()

  receive_sms: (body, from) ->
    return if body.length is 0
    user = @userForId from

		# TODO Assign self.robot.name here instead of Nurph
    if body.match(/^Nurph\b/i) is null
      console.log "I'm adding 'Nurph' as a prefix."
      body = 'Nurph' + '' + body

    @receive new Robot.TextMessage user, body

  send_sms: (message, to, callback) ->
    auth = new Buffer(@sid + ':' + @token).toString("base64")
    data = QS.stringify From: @from, To: to, Body: message

    @http("https://api.twilio.com")
      .path("/2010-04-01/Accounts/#{@sid}/SMS/Messages.json")
      .header("Authorization", "Basic #{auth}")
      .header("Content-Type", "application/x-www-form-urlencoded")
      .post(data) (err, res, body) ->
        if err
          callback err
        else if res.statusCode is 201
          json = JSON.parse(body)
          callback null, body
        else
          json = JSON.parse(body)
          callback body.message

exports.use = (robot) ->
  new Twilio robot

