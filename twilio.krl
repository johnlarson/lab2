ruleset twilio {
	meta {
		name "Twilio"
		description << Twilio client library. >>
		configure using sid = ""
		                auth_token = ""
		provides
			send, messages
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

		messages = function(page_size, page) {
			url = <<https://#{sid}:#{auth_token}@api.twilio.com/2010-04-01/Accounts/#{sid}/Messages.json>>;
			url.klog();
			response = http:get(url, qs = {
				"PageSize": page_size
			});
			response["content"].decode()
		}
	}
}