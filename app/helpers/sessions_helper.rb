module SessionsHelper

	def sign_in(user)
		#create a new remember token
		remember_token = User.new_remember_token
		#place token inside of the browser
		cookies.permanent[:remember_token] = remember_token
		#save the hashed token to the database
		user.update_attribute(:remember_token, 
                         User.hash(remember_token))
		#set the current user to be the given user
		self.current_user = user
	end

#method creating for self.current_user
	def current_user=(user)
		@current_user = user
	end

  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

	# checks if someone is currently signed in
	def signed_in?
		!current_user.nil?
	end

  def sign_out
    current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

=begin

This is for anyone that cares about how long a user is signed
in:

Currently I have a user to be signed in forever unless they
log out (cookies.permanent....).

If you want to change that, change line 7 to this:

cookies[:remember_token] = { value: remember_token, 
                            expires: 20.years.from_now.utc }

which will expire the cookie in 20 years from its date of
creation.

Oddly enough, this line above is equivalent to the:

cookies.permanent

This is just a short cut for this line since most people 
create permanent cookies these days.

Other times are:

10.weeks.from_now

5.days.ago

etc...

=end

end
