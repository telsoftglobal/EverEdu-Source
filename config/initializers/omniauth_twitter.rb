OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, 'my Google client id', 'my Google client secret', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  # provider :twitter, '7tRZ7mlv7vGMICgKn2muJrpCH', 'OGr8cLnEZSX4pszy0yN8r4wMw9NbwVm8vI8mvT3Kpxi4Vtmbid', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  #provider :twitter, '9X8Zp9C4RAnc3Tk2gAKzoVNlg', '6QdUNZX9xniD85DeqEngUNKQbn65Ib07iqhAyMSy8KnTPQ8J3G', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

  #everedu-test
  provider :twitter, 'y7jMYiNfuTxIhdtt1UIZuobf8', 'lXSeMr5QlRVSF7DEoV5LKLXRuQuUXOZ32UVdZ7puLQ514oJbGg', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}


  # everedu-ja
  # provider :twitter, 'j9ME66ZbHrcFqe3CtaNvV2e0l', 'Jr0Mh51hyMF6uF5wh9x2UGWWjItd2pUVA53utYLIzyCPD6AQaY', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

end