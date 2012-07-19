require 'rubygems'
require 'plist'
require 'awesome_print'

class String
  def to_prefix
    self.strip.downcase.gsub(/\W+/, '-')
  end
end

LAUNCHBAR_PLIST_PATH = "#{Dir.home}/Library/Application Support/LaunchBar/Configuration.plist"
ALFRED_PLIST_PATH = "#{Dir.home}/Library/Application Support/Alfred/customsites/customsites.plist"

launchbar_plist = Plist::parse_xml LAUNCHBAR_PLIST_PATH

launchbar_searches = []
launchbar_plist['rules'].each do |rule|
  launchbar_searches << rule if rule['className'] == "ODLBSearchTemplatesRule"
end

converted_searches = []
launchbar_searches.each_with_index do |search, index|
  alias_matches = search['aliasName'].match(/(Custom )?Search Templates( \((.*)\))?/)
  prefix = alias_matches[1] ? alias_matches[1].to_prefix : alias_matches[3].to_prefix
  
  search['templates'].each do |template|
    template_name = template['name'].to_prefix
    template_url = template['templateURL'].sub('*', '{query}')
    
    search = {
      keyword: "lb-#{prefix}-#{template_name}",
      spaces: false,
      text: "#{template['name']} #{search['aliasName'].to_s.sub('Templates', 'Template')}".strip,
      url: template_url,
      utf8: alias_matches[3].to_s == 'UTF-8',
    }
    
    converted_searches << search
  end
end

ap converted_searches
