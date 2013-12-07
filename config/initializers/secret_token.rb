# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# improving security of our app in deployment.
# if this change created a bug, check out the post here
# http://daniel.fone.net.nz/blog/2013/05/20/a-better-way-to-manage-the-rails-secret-token/
BCalIntegration::Application.config.secret_token = if Rails.env.development? or Rails.env.test?
  'a172e66493427aee984d01e189e4a5be668e79488b15fd57de35da76b0a8c947423caa0e4da7657aa6a324c2522ddc5c5f97e4a70fa7b086576713588956dad7'
else
  ENV['SECRET_TOKEN'] || "07c58d8c35f1f1d97c579a4334b70a026a2885705a3e2684def83ef45b3a0b37dc3cf47dfd10ad374701a261324357e3f35eb8991074bec5666513ab592c6926"
end