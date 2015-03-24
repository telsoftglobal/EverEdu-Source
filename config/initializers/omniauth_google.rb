OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, 'my Google client id', 'my Google client secret', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  # provider :google_oauth2, '267668610747-2n7b9cimtodgf3ra5c4q8ol0mub5sal7.apps.googleusercontent.com', '5-ftyjNvutTReOMB8g1FevAd', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  #provider :google_oauth2, '308718568026-dno9stmomaep2ba38km50v0ohf4hn5m2.apps.googleusercontent.com', '0z7SorJIPngauWgyaQdtXS3b', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

  #everedu-test
  #166598308293-29o65o6b0lsv8621rt451aqu1hgtufpl.apps.googleusercontent.com
  # provider :google_oauth2, '166598308293-29o65o6b0lsv8621rt451aqu1hgtufpl.apps.googleusercontent.com', 'osuZpFwyCfTxWqyxf0Sp3NTN', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

  #everedu-ja
  provider :google_oauth2, '63128646032-4fhvorcneudiqv8eh5nkfdm8c3php4rs.apps.googleusercontent.com', 'k_l_cakcuMROo4K8aKbRpPE1', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end