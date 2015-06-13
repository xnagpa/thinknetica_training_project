module AcceptanceHelper
	def sign_in(user)
		visit new_user_session_path #'/sign_in' #new_user_session_path
		fill_in 'Email', with: user.email
		fill_in 'Password', with:user.password	
		save_and_open_page	
		click_on 'Log in'
	end
end