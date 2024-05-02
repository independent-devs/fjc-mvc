if Rails.env.development? || Rails.env.test?
  Rails.application.routes.default_url_options[:host] = 'http://127.0.0.1:3000'
end
