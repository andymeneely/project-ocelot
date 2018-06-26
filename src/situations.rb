require 'squib'
require_relative 'version'
require_relative 'helpers'

data = Squib.xlsx(file: 'data/game.xlsx', sheet: 2) do |col, item|
  newlineate(col, item)
end

data['subtitle'] = data.type_1.zip(data.type_2, data.level).map do | (t1, t2, lvl) |
  "Level #{lvl} #{t1} #{t2}"
end

save_prettily(data, 'situations.txt')

Squib::Deck.new(cards: data.nrows) do
  background color: :white
  use_layout file: 'layouts/situations.yml'

  text str: data.name, layout: :name
  text str: data.subtitle, layout: :subtitle

  %w(treat extinguish clear shoot defuse contain).each do | need |
    emojis = data[need].map do |n|
      n.to_i == 0 ? '' : emoji_for(need)
    end
    text str: emojis, layout: need

    text str: data[need],
         layout: need,
         font: 'Franklin Gothic Heavy, Serif 10',
         valign: :bottom,
         align: :right,
         width: 190

    rect layout: need
  end

  text str: data.special, layout: :special

  text str: ProjectOcelot::VERSION, layout: :version

  build(:proofs) do
    safe_zone
    cut_zone
  end

  save format: :png, prefix: 'situation_'

  build(:pdf) do
    save_pdf file: 'situations.pdf'
  end

  build(:pnp) do
    save_sheet prefix: 'pnp_sheet_',
               trim: '0.125in',
               rows: 3, columns: 3
  end
end
