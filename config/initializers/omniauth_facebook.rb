OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, '344089822427119', 'fa2e13786bb30222cec63b0edaefbded', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
  #provider :facebook, '578596308951664', '0a03b338c6ad450a5e57c1472f5e5f5a', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}

  #everedu-test
  provider :facebook, '616446411790001', '4608a962ed99dc5d244afac071b7c02d', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}

  #everedu-ja
  # provider :facebook, '1100409866641950', '1e28c53d3def8f6f4753ef16453d9bcc', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end