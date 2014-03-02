class User < ActiveRecord::Base

before_save { self.email = email.downcase }
before_save { self.user_name = user_name.downcase }

=begin

VAILD_EMAIL is the regex used to valid a user given email.

A break down of the regex is listed below.

/ -----------> Start of the regex
\A ----------> match start of a string
[\w+\-.]+ ---> at least one owrd character, plus, hyphen, or 
			   dot
@ -----------> literal ampersand
[a-z\d\-.]+ -> at least one letter, digit, hyphen, or dot
(?:\.[a-z]+) > ensures that the error of example@foo..com
							 does not occur
\z ----------> match end of a string
/ -----------> end of the regex
i -----------> case sensative

=end
		
	VALID_EMAIL_REG = /\A[\w+\-.]+@[a-z\d\-.]+(?:\.[a-z]+)\z/i

=begin

VALID_USER_NAME checks to make sure a user's user_name
is in the proper format.

=end

	VALID_USER_NAME_REG = /[a-zA-Z0-9\-]/

=begin

The following lines put a user accout through a series of
validations in order to make sure all of their information
is in the proper format.

validates :symbol_to_be_valided

presence: determines whether or not a symbol is filled or not
length: ensures there is a length limit on the symbol
format: checks the format of given information to ensure 
        validity

=end

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: {with: 
                                       VALID_EMAIL_REG},
                      uniqueness: { case_sensitive: false }
  validates :user_name, presence: true, length:{maximum: 50},
                        format: {with: VALID_USER_NAME_REG },
                        uniqueness: {case_sensitive: false }

=begin

Instead of adding password and password_confirmation
attributes, requiring the presence of a password, 
requirin that pw and pw_com match, and add an authenticate
method to compare an encrypted password to the
password_digest to authenticate users, I can just add
has_secure_password which does all of this for me

=end

	has_secure_password

	validates :password, length: { minimum: 6 }

=begin

in order to ensure that someone did not accidently submit
two accounts rapidly (which would throw off the validates 
for user_name and email) I added an index to the Users 
email and user_name in the database to ensure uniqueness
This also gives and index to the user_name and email
so finding a unique user SHOULD be easier

=end

end
