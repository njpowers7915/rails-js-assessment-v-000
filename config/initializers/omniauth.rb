#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
#    provider_ignores_state: true
#  }
#end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

#auth_client.update!(
#  :additional_parameters => {"access_type" => "offline"}
#)
