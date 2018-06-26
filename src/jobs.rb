
require 'squib'
require_relative 'version'
require_relative 'helpers'

data = Squib.xlsx(file: 'data/game.xlsx', sheet: 0) do |col, item|
  newlineate(col, item)
end

save_prettily(data, 'jobs.txt')

Squib::Deck.new(cards: data.nrows, width: 900, height: 1500) do
  background color: :white
  use_layout file: 'layouts/jobs.yml'

  text str: data.name, layout: :name
  text str: data.career, layout: :career

  text str: data.initial_energy.map { |e| "Initial: #{e}" },
       layout: :initial_energy

  text str: data.speed.map { |s| "Speed: #{s}" },
       layout: :speed

  1.upto(6) do |i|
    rect layout: "action_#{i.to_s}"
    text str: data["Action #{i.to_s}"], layout: "action_#{i.to_s}"
    text str: data["A#{i.to_s}Cost"],
         layout: "action_#{i.to_s}",
         align: :right,
         valign: :bottom,
         font: 'Arial Black,Sans bold, 10',
         width: 290
  end

  text str: data.special, layout: :special

  rect layout: :art # Placeholder for now

  text str: ProjectOcelot::VERSION, layout: :version

  build(:proofs) do
    safe_zone
    cut_zone
  end

  save format: :png

  # build(:pdf) do
  save_pdf file: 'jobs.pdf',
           width: 8.5 * dpi,
           height: 11 * dpi

  # end

  build(:pnp) do
    save_sheet prefix: 'pnp_sheet_',
               trim: '0.125in',
               rows: 3, columns: 3
  end
end
