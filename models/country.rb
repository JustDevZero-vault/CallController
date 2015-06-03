# -*- coding: utf-8 -*-
class Country
  include DataMapper::Resource
  
  def self.default_repository_name #here we use the users_db for the User objects
    :default
  end

  property :id, Serial, :key => true
  property :iso_code, String, :length => 2
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :provinces
  
  def self.begin_migrate
   first_or_create(:iso_code => 'AD', :name => CGI::escapeHTML(Rack::Utils.escape_html('Andorra')))
   first_or_create(:iso_code => 'AE', :name => CGI::escapeHTML(Rack::Utils.escape_html('United Arab Emirates')))
   first_or_create(:iso_code => 'AF', :name => CGI::escapeHTML(Rack::Utils.escape_html('Afghanistan')))
   first_or_create(:iso_code => 'AG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Antigua and Barbuda')))
   first_or_create(:iso_code => 'AI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Anguilla')))
   first_or_create(:iso_code => 'AL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Albania')))
   first_or_create(:iso_code => 'AM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Armenia')))
   first_or_create(:iso_code => 'AO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Angola')))
   first_or_create(:iso_code => 'AQ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Antarctica')))
   first_or_create(:iso_code => 'AR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Argentina')))
   first_or_create(:iso_code => 'AS', :name => CGI::escapeHTML(Rack::Utils.escape_html('American Samoa')))
   first_or_create(:iso_code => 'AT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Austria')))
   first_or_create(:iso_code => 'AU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Australia')))
   first_or_create(:iso_code => 'AW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Aruba')))
   first_or_create(:iso_code => 'AX', :name => CGI::escapeHTML(Rack::Utils.escape_html('Åland Islands')))
   first_or_create(:iso_code => 'AZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Azerbaijan')))
   first_or_create(:iso_code => 'BA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bosnia and Herzegovina')))
   first_or_create(:iso_code => 'BB', :name => CGI::escapeHTML(Rack::Utils.escape_html('Barbados')))
   first_or_create(:iso_code => 'BD', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bangladesh')))
   first_or_create(:iso_code => 'BE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Belgium')))
   first_or_create(:iso_code => 'BF', :name => CGI::escapeHTML(Rack::Utils.escape_html('Burkina Faso')))
   first_or_create(:iso_code => 'BG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bulgaria')))
   first_or_create(:iso_code => 'BH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bahrain')))
   first_or_create(:iso_code => 'BI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Burundi')))
   first_or_create(:iso_code => 'BJ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Benin')))
   first_or_create(:iso_code => 'BL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Saint Barthélemy')))
   first_or_create(:iso_code => 'BM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bermuda')))
   first_or_create(:iso_code => 'BN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Brunei Darussalam')))
   first_or_create(:iso_code => 'BO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bolivia')))
   first_or_create(:iso_code => 'BQ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Caribbean Netherlands ')))
   first_or_create(:iso_code => 'BR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Brazil')))
   first_or_create(:iso_code => 'BS', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bahamas')))
   first_or_create(:iso_code => 'BT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bhutan')))
   first_or_create(:iso_code => 'BV', :name => CGI::escapeHTML(Rack::Utils.escape_html('Bouvet Island')))
   first_or_create(:iso_code => 'BW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Botswana')))
   first_or_create(:iso_code => 'BY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Belarus')))
   first_or_create(:iso_code => 'BZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Belize')))
   first_or_create(:iso_code => 'CA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Canada')))
   first_or_create(:iso_code => 'CC', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cocos (Keeling) Islands')))
   first_or_create(:iso_code => 'CD', :name => CGI::escapeHTML(Rack::Utils.escape_html('Congo, Democratic Republic of')))
   first_or_create(:iso_code => 'CF', :name => CGI::escapeHTML(Rack::Utils.escape_html('Central African Republic')))
   first_or_create(:iso_code => 'CG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Congo')))
   first_or_create(:iso_code => 'CH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Switzerland')))
   first_or_create(:iso_code => 'CI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Côte Ivoire')))
   first_or_create(:iso_code => 'CK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cook Islands')))
   first_or_create(:iso_code => 'CL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Chile')))
   first_or_create(:iso_code => 'CM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cameroon')))
   first_or_create(:iso_code => 'CN', :name => CGI::escapeHTML(Rack::Utils.escape_html('China')))
   first_or_create(:iso_code => 'CO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Colombia')))
   first_or_create(:iso_code => 'CR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Costa Rica')))
   first_or_create(:iso_code => 'CU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cuba')))
   first_or_create(:iso_code => 'CV', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cape Verde')))
   first_or_create(:iso_code => 'CW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Curaçao')))
   first_or_create(:iso_code => 'CX', :name => CGI::escapeHTML(Rack::Utils.escape_html('Christmas Island')))
   first_or_create(:iso_code => 'CY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cyprus')))
   first_or_create(:iso_code => 'CZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Czech Republic')))
   first_or_create(:iso_code => 'DE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Germany')))
   first_or_create(:iso_code => 'DJ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Djibouti')))
   first_or_create(:iso_code => 'DK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Denmark')))
   first_or_create(:iso_code => 'DM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Dominica')))
   first_or_create(:iso_code => 'DO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Dominican Republic')))
   first_or_create(:iso_code => 'DZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Algeria')))
   first_or_create(:iso_code => 'EC', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ecuador')))
   first_or_create(:iso_code => 'EE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Estonia')))
   first_or_create(:iso_code => 'EG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Egypt')))
   first_or_create(:iso_code => 'EH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Western Sahara')))
   first_or_create(:iso_code => 'ER', :name => CGI::escapeHTML(Rack::Utils.escape_html('Eritrea')))
   first_or_create(:iso_code => 'ES', :name => CGI::escapeHTML(Rack::Utils.escape_html('España')))
   first_or_create(:iso_code => 'ET', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ethiopia')))
   first_or_create(:iso_code => 'FI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Finland')))
   first_or_create(:iso_code => 'FJ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Fiji')))
   first_or_create(:iso_code => 'FK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Falkland Islands')))
   first_or_create(:iso_code => 'FM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Micronesia, Federated States of')))
   first_or_create(:iso_code => 'FO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Faroe Islands')))
   first_or_create(:iso_code => 'FR', :name => CGI::escapeHTML(Rack::Utils.escape_html('France')))
   first_or_create(:iso_code => 'GA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Gabon')))
   first_or_create(:iso_code => 'GB', :name => CGI::escapeHTML(Rack::Utils.escape_html('United Kingdom')))
   first_or_create(:iso_code => 'GD', :name => CGI::escapeHTML(Rack::Utils.escape_html('Grenada')))
   first_or_create(:iso_code => 'GE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Georgia')))
   first_or_create(:iso_code => 'GF', :name => CGI::escapeHTML(Rack::Utils.escape_html('French Guiana')))
   first_or_create(:iso_code => 'GG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guernsey')))
   first_or_create(:iso_code => 'GH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ghana')))
   first_or_create(:iso_code => 'GI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Gibraltar')))
   first_or_create(:iso_code => 'GL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Greenland')))
   first_or_create(:iso_code => 'GM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Gambia')))
   first_or_create(:iso_code => 'GN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guinea')))
   first_or_create(:iso_code => 'GP', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guadeloupe')))
   first_or_create(:iso_code => 'GQ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Equatorial Guinea')))
   first_or_create(:iso_code => 'GR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Greece')))
   first_or_create(:iso_code => 'GS', :name => CGI::escapeHTML(Rack::Utils.escape_html('South Georgia and the South Sandwich Islands')))
   first_or_create(:iso_code => 'GT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guatemala')))
   first_or_create(:iso_code => 'GU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guam')))
   first_or_create(:iso_code => 'GW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guinea-Bissau')))
   first_or_create(:iso_code => 'GY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Guyana')))
   first_or_create(:iso_code => 'HK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Hong Kong')))
   first_or_create(:iso_code => 'HM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Heard and McDonald Islands')))
   first_or_create(:iso_code => 'HN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Honduras')))
   first_or_create(:iso_code => 'HR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Croatia')))
   first_or_create(:iso_code => 'HT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Haiti')))
   first_or_create(:iso_code => 'HU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Hungary')))
   first_or_create(:iso_code => 'ID', :name => CGI::escapeHTML(Rack::Utils.escape_html('Indonesia')))
   first_or_create(:iso_code => 'IE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ireland')))
   first_or_create(:iso_code => 'IL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Israel')))
   first_or_create(:iso_code => 'IM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Isle of Man')))
   first_or_create(:iso_code => 'IN', :name => CGI::escapeHTML(Rack::Utils.escape_html('India')))
   first_or_create(:iso_code => 'IO', :name => CGI::escapeHTML(Rack::Utils.escape_html('British Indian Ocean Territory')))
   first_or_create(:iso_code => 'IQ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Iraq')))
   first_or_create(:iso_code => 'IR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Iran')))
   first_or_create(:iso_code => 'IS', :name => CGI::escapeHTML(Rack::Utils.escape_html('Iceland')))
   first_or_create(:iso_code => 'IT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Italy')))
   first_or_create(:iso_code => 'JE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Jersey')))
   first_or_create(:iso_code => 'JM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Jamaica')))
   first_or_create(:iso_code => 'JO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Jordan')))
   first_or_create(:iso_code => 'JP', :name => CGI::escapeHTML(Rack::Utils.escape_html('Japan')))
   first_or_create(:iso_code => 'KE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Kenya')))
   first_or_create(:iso_code => 'KG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Kyrgyzstan')))
   first_or_create(:iso_code => 'KH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cambodia')))
   first_or_create(:iso_code => 'KI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Kiribati')))
   first_or_create(:iso_code => 'KM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Comoros')))
   first_or_create(:iso_code => 'KN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Saint Kitts and Nevis')))
   first_or_create(:iso_code => 'KP', :name => CGI::escapeHTML(Rack::Utils.escape_html('North Korea')))
   first_or_create(:iso_code => 'KR', :name => CGI::escapeHTML(Rack::Utils.escape_html('South Korea')))
   first_or_create(:iso_code => 'KW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Kuwait')))
   first_or_create(:iso_code => 'KY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Cayman Islands')))
   first_or_create(:iso_code => 'KZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Kazakhstan')))
   first_or_create(:iso_code => 'LA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Laos')))
   first_or_create(:iso_code => 'LB', :name => CGI::escapeHTML(Rack::Utils.escape_html('Lebanon')))
   first_or_create(:iso_code => 'LC', :name => CGI::escapeHTML(Rack::Utils.escape_html('Saint Lucia')))
   first_or_create(:iso_code => 'LI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Liechtenstein')))
   first_or_create(:iso_code => 'LK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Sri Lanka')))
   first_or_create(:iso_code => 'LR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Liberia')))
   first_or_create(:iso_code => 'LS', :name => CGI::escapeHTML(Rack::Utils.escape_html('Lesotho')))
   first_or_create(:iso_code => 'LT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Lithuania')))
   first_or_create(:iso_code => 'LU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Luxembourg')))
   first_or_create(:iso_code => 'LV', :name => CGI::escapeHTML(Rack::Utils.escape_html('Latvia')))
   first_or_create(:iso_code => 'LY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Libya')))
   first_or_create(:iso_code => 'MA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Morocco')))
   first_or_create(:iso_code => 'MC', :name => CGI::escapeHTML(Rack::Utils.escape_html('Monaco')))
   first_or_create(:iso_code => 'MD', :name => CGI::escapeHTML(Rack::Utils.escape_html('Moldova')))
   first_or_create(:iso_code => 'ME', :name => CGI::escapeHTML(Rack::Utils.escape_html('Montenegro')))
   first_or_create(:iso_code => 'MF', :name => CGI::escapeHTML(Rack::Utils.escape_html('Saint-Martin (France))')))
   first_or_create(:iso_code => 'MG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Madagascar')))
   first_or_create(:iso_code => 'MH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Marshall Islands')))
   first_or_create(:iso_code => 'MK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Macedonia')))
   first_or_create(:iso_code => 'ML', :name => CGI::escapeHTML(Rack::Utils.escape_html('Mali')))
   first_or_create(:iso_code => 'MM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Myanmar')))
   first_or_create(:iso_code => 'MN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Mongolia')))
   first_or_create(:iso_code => 'MO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Macau')))
   first_or_create(:iso_code => 'MP', :name => CGI::escapeHTML(Rack::Utils.escape_html('Northern Mariana Islands')))
   first_or_create(:iso_code => 'MQ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Martinique')))
   first_or_create(:iso_code => 'MR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Mauritania')))
   first_or_create(:iso_code => 'MS', :name => CGI::escapeHTML(Rack::Utils.escape_html('Montserrat')))
   first_or_create(:iso_code => 'MT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Malta')))
   first_or_create(:iso_code => 'MU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Mauritius')))
   first_or_create(:iso_code => 'MV', :name => CGI::escapeHTML(Rack::Utils.escape_html('Maldives')))
   first_or_create(:iso_code => 'MW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Malawi')))
   first_or_create(:iso_code => 'MX', :name => CGI::escapeHTML(Rack::Utils.escape_html('Mexico')))
   first_or_create(:iso_code => 'MY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Malaysia')))
   first_or_create(:iso_code => 'MZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Mozambique')))
   first_or_create(:iso_code => 'NA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Namibia')))
   first_or_create(:iso_code => 'NC', :name => CGI::escapeHTML(Rack::Utils.escape_html('New Caledonia')))
   first_or_create(:iso_code => 'NE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Niger')))
   first_or_create(:iso_code => 'NF', :name => CGI::escapeHTML(Rack::Utils.escape_html('Norfolk Island')))
   first_or_create(:iso_code => 'NG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Nigeria')))
   first_or_create(:iso_code => 'NI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Nicaragua')))
   first_or_create(:iso_code => 'NL', :name => CGI::escapeHTML(Rack::Utils.escape_html('The Netherlands')))
   first_or_create(:iso_code => 'NO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Norway')))
   first_or_create(:iso_code => 'NP', :name => CGI::escapeHTML(Rack::Utils.escape_html('Nepal')))
   first_or_create(:iso_code => 'NR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Nauru')))
   first_or_create(:iso_code => 'NU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Niue')))
   first_or_create(:iso_code => 'NZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('New Zealand')))
   first_or_create(:iso_code => 'OM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Oman')))
   first_or_create(:iso_code => 'PA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Panama')))
   first_or_create(:iso_code => 'PE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Peru')))
   first_or_create(:iso_code => 'PF', :name => CGI::escapeHTML(Rack::Utils.escape_html('French Polynesia')))
   first_or_create(:iso_code => 'PG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Papua New Guinea')))
   first_or_create(:iso_code => 'PH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Philippines')))
   first_or_create(:iso_code => 'PK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Pakistan')))
   first_or_create(:iso_code => 'PL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Poland')))
   first_or_create(:iso_code => 'PM', :name => CGI::escapeHTML(Rack::Utils.escape_html('St. Pierre and Miquelon')))
   first_or_create(:iso_code => 'PN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Pitcairn')))
   first_or_create(:iso_code => 'PR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Puerto Rico')))
   first_or_create(:iso_code => 'PS', :name => CGI::escapeHTML(Rack::Utils.escape_html('Palestine, State of')))
   first_or_create(:iso_code => 'PT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Portugal')))
   first_or_create(:iso_code => 'PW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Palau')))
   first_or_create(:iso_code => 'PY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Paraguay')))
   first_or_create(:iso_code => 'QA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Qatar')))
   first_or_create(:iso_code => 'RE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Réunion')))
   first_or_create(:iso_code => 'RO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Romania')))
   first_or_create(:iso_code => 'RS', :name => CGI::escapeHTML(Rack::Utils.escape_html('Serbia')))
   first_or_create(:iso_code => 'RU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Russian Federation')))
   first_or_create(:iso_code => 'RW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Rwanda')))
   first_or_create(:iso_code => 'SA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Saudi Arabia')))
   first_or_create(:iso_code => 'SB', :name => CGI::escapeHTML(Rack::Utils.escape_html('Solomon Islands')))
   first_or_create(:iso_code => 'SC', :name => CGI::escapeHTML(Rack::Utils.escape_html('Seychelles')))
   first_or_create(:iso_code => 'SD', :name => CGI::escapeHTML(Rack::Utils.escape_html('Sudan')))
   first_or_create(:iso_code => 'SE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Sweden')))
   first_or_create(:iso_code => 'SG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Singapore')))
   first_or_create(:iso_code => 'SH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Saint Helena')))
   first_or_create(:iso_code => 'SI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Slovenia')))
   first_or_create(:iso_code => 'SJ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Svalbard and Jan Mayen Islands')))
   first_or_create(:iso_code => 'SK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Slovakia')))
   first_or_create(:iso_code => 'SL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Sierra Leone')))
   first_or_create(:iso_code => 'SM', :name => CGI::escapeHTML(Rack::Utils.escape_html('San Marino')))
   first_or_create(:iso_code => 'SN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Senegal')))
   first_or_create(:iso_code => 'SO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Somalia')))
   first_or_create(:iso_code => 'SR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Suriname')))
   first_or_create(:iso_code => 'SS', :name => CGI::escapeHTML(Rack::Utils.escape_html('South Sudan')))
   first_or_create(:iso_code => 'ST', :name => CGI::escapeHTML(Rack::Utils.escape_html('Sao Tome and Principe')))
   first_or_create(:iso_code => 'SV', :name => CGI::escapeHTML(Rack::Utils.escape_html('El Salvador')))
   first_or_create(:iso_code => 'SX', :name => CGI::escapeHTML(Rack::Utils.escape_html('Sint Maarten (Dutch part))')))
   first_or_create(:iso_code => 'SY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Syria')))
   first_or_create(:iso_code => 'SZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Swaziland')))
   first_or_create(:iso_code => 'TC', :name => CGI::escapeHTML(Rack::Utils.escape_html('Turks and Caicos Islands')))
   first_or_create(:iso_code => 'TD', :name => CGI::escapeHTML(Rack::Utils.escape_html('Chad')))
   first_or_create(:iso_code => 'TF', :name => CGI::escapeHTML(Rack::Utils.escape_html('French Southern Territories')))
   first_or_create(:iso_code => 'TG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Togo')))
   first_or_create(:iso_code => 'TH', :name => CGI::escapeHTML(Rack::Utils.escape_html('Thailand')))
   first_or_create(:iso_code => 'TJ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Tajikistan')))
   first_or_create(:iso_code => 'TK', :name => CGI::escapeHTML(Rack::Utils.escape_html('Tokelau')))
   first_or_create(:iso_code => 'TL', :name => CGI::escapeHTML(Rack::Utils.escape_html('Timor-Leste')))
   first_or_create(:iso_code => 'TM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Turkmenistan')))
   first_or_create(:iso_code => 'TN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Tunisia')))
   first_or_create(:iso_code => 'TO', :name => CGI::escapeHTML(Rack::Utils.escape_html('Tonga')))
   first_or_create(:iso_code => 'TR', :name => CGI::escapeHTML(Rack::Utils.escape_html('Turkey')))
   first_or_create(:iso_code => 'TT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Trinidad and Tobago')))
   first_or_create(:iso_code => 'TV', :name => CGI::escapeHTML(Rack::Utils.escape_html('Tuvalu')))
   first_or_create(:iso_code => 'TW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Taiwan')))
   first_or_create(:iso_code => 'TZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Tanzania')))
   first_or_create(:iso_code => 'UA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Ukraine')))
   first_or_create(:iso_code => 'UG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Uganda')))
   first_or_create(:iso_code => 'UM', :name => CGI::escapeHTML(Rack::Utils.escape_html('United States Minor Outlying Islands')))
   first_or_create(:iso_code => 'US', :name => CGI::escapeHTML(Rack::Utils.escape_html('United States')))
   first_or_create(:iso_code => 'UY', :name => CGI::escapeHTML(Rack::Utils.escape_html('Uruguay')))
   first_or_create(:iso_code => 'UZ', :name => CGI::escapeHTML(Rack::Utils.escape_html('Uzbekistan')))
   first_or_create(:iso_code => 'VA', :name => CGI::escapeHTML(Rack::Utils.escape_html('Vatican')))
   first_or_create(:iso_code => 'VC', :name => CGI::escapeHTML(Rack::Utils.escape_html('Saint Vincent and the Grenadines')))
   first_or_create(:iso_code => 'VE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Venezuela')))
   first_or_create(:iso_code => 'VG', :name => CGI::escapeHTML(Rack::Utils.escape_html('Virgin Islands (British)')))
   first_or_create(:iso_code => 'VI', :name => CGI::escapeHTML(Rack::Utils.escape_html('Virgin Islands (U.S.)')))
   first_or_create(:iso_code => 'VN', :name => CGI::escapeHTML(Rack::Utils.escape_html('Vietnam')))
   first_or_create(:iso_code => 'VU', :name => CGI::escapeHTML(Rack::Utils.escape_html('Vanuatu')))
   first_or_create(:iso_code => 'WF', :name => CGI::escapeHTML(Rack::Utils.escape_html('Wallis and Futuna Islands')))
   first_or_create(:iso_code => 'WS', :name => CGI::escapeHTML(Rack::Utils.escape_html('Samoa')))
   first_or_create(:iso_code => 'YE', :name => CGI::escapeHTML(Rack::Utils.escape_html('Yemen')))
   first_or_create(:iso_code => 'YT', :name => CGI::escapeHTML(Rack::Utils.escape_html('Mayotte')))
   first_or_create(:iso_code => 'ZA', :name => CGI::escapeHTML(Rack::Utils.escape_html('South Africa')))
   first_or_create(:iso_code => 'ZM', :name => CGI::escapeHTML(Rack::Utils.escape_html('Zambia')))
   first_or_create(:iso_code => 'ZW', :name => CGI::escapeHTML(Rack::Utils.escape_html('Zimbabwe')))
  end
end
