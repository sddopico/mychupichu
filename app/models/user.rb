class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     	 :omniauthable
 	
	has_many :chus

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		if user
			return user
		else
			registered_user = User.where(:email => auth.info.email).first
		  	if registered_user
				return registered_user
		  	else
				user = User.create(name:auth.extra.raw_info.name,
						provider:auth.provider,
						uid:auth.uid,
						email:auth.info.email,
						password:Devise.friendly_token[0,20],
					  )
		  	end
		end
	end
	def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		if user
			return user
		else
			registered_user = User.where(:email => auth.info.email).first
		  	if registered_user
				return registered_user
		  	else
				user = User.create(name:auth.extra.raw_info.firstName + ' ' + auth.extra.raw_info.lastName,
						provider:auth.provider,
						uid:auth.uid,
						email:auth.info.email,
						password:Devise.friendly_token[0,20],
					  )
		  	end
		end
	end
	
	def fullname
		a = name
		b = a.titleize
		return b
	end
end