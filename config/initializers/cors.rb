Rails.application.config.hosts << 'http://localhost:19006'
Rails.application.config.hosts << 'oxford-english-vocabulary.herokuapp.com' if Rails.env.production?

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post patch put]
  end
end
