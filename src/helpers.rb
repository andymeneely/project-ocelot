require 'game_icons'

def treat_svg
  GameIcons.get('medical-pack').recolor(fg: 'fff', bg: '000').string
end

def save_prettily(data, name)
  File.open("data/#{name}", 'w+') do |f|
    f.write data.to_pretty_text
  end
end

# process XLSX data and just replace %n with a newline
def newlineate(col, item)
  return nil if item.nil?
  item.to_s.gsub "%n", "\n"
end

def emoji_for(str)
  case str.to_s.downcase
  when 'CThru'      then '👁'
  when 'energy'     then '⚡'
  when 'defuse'     then '💣'
  when 'clear'      then '💪'
  when 'contain'    then '☣'
  when 'request'    then '✋'
  when 'shoot'      then '🔫'
  when 'treat'      then '➕'
  when 'extinguish' then '🔥'
  end
end
