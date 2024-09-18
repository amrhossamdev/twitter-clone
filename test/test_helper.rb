ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Set up all fixtures in test/fixtures/*.yml.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Return true if the user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a user
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  def log_in_as(user, foo: "password", remember_me: "1")
    post login_path, params: { session: { email: user.email, password: foo, remember_me: remember_me } }
  end
end
