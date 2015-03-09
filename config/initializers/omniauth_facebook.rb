OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '344089822427119', 'fa2e13786bb30222cec63b0edaefbded', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
  #provider :facebook, '578596308951664', '0a03b338c6ad450a5e57c1472f5e5f5a', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end