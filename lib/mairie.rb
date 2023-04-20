require "nokogiri"
require "open-uri"
# cette fonction récupère les urls de toutes les pages individuelles de mairies
def get_urls
  page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  url_list = []
  urls = page.xpath('//a[contains(@class, "lientxt")]')
  urls.each do |href|
    url_list << href.values[1].delete_prefix(".")
  end 
  return url_list
end 
# cette méthode vise à parser l'adresse mail d'une mairie depuis son site 
def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  email = page.xpath('//td[text()="Adresse Email"]//following-sibling::td')
  return final_email = email.map {|td| td.text}
end 
# cette méthode renvoie une liste de tous les mails sous forme d'array  
def parse_mails 
  url_list = get_urls 
  email_list = []
  url_list.each do |url|
    email_list.push(get_townhall_email("https://www.annuaire-des-mairies.com" + url))
  end
  return email_list 
end 
# cette méthode récupère les noms des villes dans un array
def parse_names 
  page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  names = page.xpath('//a[contains(@class, "lientxt")]')
  name_list = []
  name_list = names.map {|href| href.text}
  return name_list
end 
# cette méthode affiche un array qui contient un hash par ville, au format nom => email 
def final_array 
  final_list = []
  email_list = parse_mails 
  name_list = parse_names 
  final_list = name_list.map.with_index do |name, i| 
    name_list.zip(email_list[i]) 
  end
  puts final_list 
end

final_array





