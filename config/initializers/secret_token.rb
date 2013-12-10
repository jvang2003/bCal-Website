# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# improving security of our app in deployment.
# if this change created a bug, check out the post here
# http://daniel.fone.net.nz/blog/2013/05/20/a-better-way-to-manage-the-rails-secret-token/

hard_coded_token = 'a172e66493427aee984d01e189e4a5be668e79488b15fd57de35da76b0a8c947423caa0e4da7657aa6a324c2522ddc5c5f97e4a70fa7b086576713588956dad7'
if Rails.env.development? or Rails.env.test?
  token = hard_coded_token
elsif ENV['SECRET_TOKEN'] == nil or ENV['SECRET_TOKEN'].length < 30
	puts "USING HARD CODED SECRET TOKEN IN DEPLOYMENT"
  token = hard_coded_token
else
	token = ENV['SECRET_TOKEN']
end
BCalIntegration::Application.config.secret_token = token