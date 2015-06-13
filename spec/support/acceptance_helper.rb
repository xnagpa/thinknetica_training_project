module AcceptanceHelper
	def sign_in(user)
		visit new_user_session_path #'/sign_in' #new_user_session_path
		if user.id==2
			byebug
			save_and_open_page		
		end
		fill_in 'Email', with: user.email		
		fill_in 'Password', with: user.password	
		click_on 'Log in'
	end

	def sign_out(user)
	
	 # save_and_open_page	
	#	sign_out(user)
	end
end