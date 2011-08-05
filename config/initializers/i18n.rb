=begin
I18n.default_locale = :en
LANGUAGES = [
['English', 'en'],
["Espa&ntilde;ol".html_safe, 'es']
]
=end

I18n.default_locale = 'zh'
LOCALES_DIRECTORY = "#{::Rails.root.to_s}/config/locales/"

LANGUAGES = {
  'English' => 'en',
  'Chinese' => 'zh'
}