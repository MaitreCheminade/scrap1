require "nokogiri"
require "open-uri"
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
crypto = {}
parse_values = page.xpath('//tr[@class="cmc-table-row"]')
crypto_names = []
crypto_values = []
parse_values.each do |crypto_value|
  crypto_names << crypto_value.xpath('td[2]/div/a[2]').text # extraire le nom de la crypto
  crypto_values << crypto_value.xpath('td[5]/div/a/span').text # extraire la valeur de la crypto
end 
puts crypto = Hash[crypto_names.zip(crypto_values)]
