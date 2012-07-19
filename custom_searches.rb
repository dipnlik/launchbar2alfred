require 'rubygems'
require 'plist'
require 'awesome_print'

class String
  def to_prefix
    self.strip.downcase.gsub(/\W+/, '-')
  end
end

launchbar_plist_path = "#{Dir.home}/Library/Application Support/LaunchBar/Configuration.plist"
alfred_plist_path = "#{Dir.home}/Library/Application Support/Alfred/customsites/customsites.plist"

launchbar_plist = Plist::parse_xml( launchbar_plist_path )

launchbar_searches = []
launchbar_plist['rules'].each do |rule|
  launchbar_searches << rule if rule['className'] == "ODLBSearchTemplatesRule"
end

launchbar_searches.each_with_index do |search, index|
  alias_matches = search['aliasName'].match(/(Custom )?Search Templates( \((.*)\))?/)
  prefix = alias_matches[1] ? alias_matches[1].to_prefix : alias_matches[3].to_prefix
  
  search['templates'].each do |template|
    template_name = template['name'].to_prefix
    template_url = template['templateURL'].sub('*', '{query}')
    
    STDOUT.puts <<-SEARCH
lb-#{prefix}-#{template_name}
#{template['name']} #{search['aliasName'].sub('Templates', 'Template')} 
#{template_url}

SEARCH
  end
end

# @x = launchbar_searches
# puts "@x ready."
