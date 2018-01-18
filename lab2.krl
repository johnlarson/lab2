ruleset lab2 {
	meta {
		use module twilio_keys
		use module twilio with
			sid = keys:twilio{"sid"} and
			auth_token = keys:twilio{"auth_token"}
	}
}