class HomeController < ApplicationController

	def index
		@categories = Category.all
		@last_topics = Topic.get_last_updated_topics
		@last_users = User.last(5)
	end

end
