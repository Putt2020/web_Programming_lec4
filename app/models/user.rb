#class LoggingIn < ActiveModel::Validator
#	def validate_pass(record)
#		if record.password != User.find_by(email: record.email).password
#			record.errors.add :base, "password or email is not valid"
#		end
#	end
#end

class User < ApplicationRecord
	has_many :posts
	validates :email, uniqueness: true, presence: true
	has_secure_password
	#validates_with LoggingIn
	#validates :name, length: {minimum : 2}
end
