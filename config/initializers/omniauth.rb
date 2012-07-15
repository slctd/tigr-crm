OAUTH_CREDENTIALS = YAML.load_file(Rails.root.join("config", "oauth.yml"))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, OAUTH_CREDENTIALS['twitter']['app_id'], OAUTH_CREDENTIALS['twitter']['app_secret']
  provider :yandex, OAUTH_CREDENTIALS['yandex']['app_id'], OAUTH_CREDENTIALS['yandex']['app_secret']
end