module Helpers
	def login(username, password)
		visit path_to(login_page)
		fill_in(:username, :with => username)
		fill_in(:password, :with => password)
		click_button("Log In")
	end
end