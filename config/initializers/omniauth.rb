Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    client_options: {
        site: 'https://graph.facebook.com/v3.0',
        authorize_url: "https://www.facebook.com/v3.0/dialog/oauth"
      }
end
