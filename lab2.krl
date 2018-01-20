ruleset lab2 {
	meta {
		name "Lab 2"
		description << Twilio client. >>
		use module twilio_keys
		use module twilio with
			sid = keys:twilio{"sid"} and
			auth_token = keys:twilio{"auth_token"}
			shares __testing
	}

	global{

		__testing = {
			"events": [
				{
					"domain": "twilio",
					"type":"send",
					"attrs": ["from", "to", "msg"]
				},
				{
					"domain": "twilio",
					"type": "messages",
					"attrs": [
						"page_size"
					]
				}
			]
		}

	}

	rule send_sms {
		select when twilio send
		pre {
			from = event:attr("from")
			to = event:attr("to")
			msg = event:attr("msg")
		}
		twilio:send(to, from, msg)
	}

	rule get_messages {
		select when twilio messages
		pre {
			page_size = event:attr("page_size")
			msgs = twilio:messages(page_size)
		}
		send_directive("messages", msgs)
	}
}