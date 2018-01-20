ruleset twilio {
	meta {
		name "Twilio"
		description << Twilio client library. >>
		configure using sid = ""
		                auth_token = ""
		provides
			send
	}

	global {

		send = defaction(to, from, msg) {
			base_url = <<https://#{sid}:#{auth_token}@api.twilio.com/2010-04-01/Accounts/#{sid}/>>
			http:post(base_url + "Messages.json", form = {
					"From":from,
					"To":to,
					"Body":msg
				})
		}
	}
}