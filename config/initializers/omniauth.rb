Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'fAuisrBG488gEIjKxv6ILA', 'HIQYBlU4u8QAKzaMJrTwGgiYqfYDYuiUtaQmxgBc'
  provider :facebook, '165253030169176', '6d6e6edd1bdf2955ec4d1d8545ca25e8'
end
