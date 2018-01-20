ruleset twilio {
	meta {
		name "Twilio"
		description << Twilio client library. >>
		configure using sid = ""
		                auth_token = ""
		provides
			send, __testing
	}

	global {
	  
	  
		send = defaction(to, from, msg) {
		  a= to.klog("module to");
		  a= from.klog("module from");
		  a= msg.klog("module msg");
		  a= auth_token.klog("module token");
		  a= sid.klog("module  sid");
			base_url = <<https://#{sid}:#{auth_token}@api.twilio.com/2010-04-01/Accounts/#{sid}/>>
			http:post(base_url + "Messages.json", form = {
					"From":from,
					"To":to,
					"Body":msg
				})
		}
	}
}