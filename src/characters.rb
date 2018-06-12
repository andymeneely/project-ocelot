require 'squib'
require_relative 'version'

data = Squib.xlsx file: 'data/game.xlsx', sheet: 0

Squib::Deck.new(cards: data.nrows) do
  background color: :white
  use_layout file: 'layouts/characters.yml'

  text str: data.name, layout: :name

  text str: data.atk.map { |s| "#{s} ATK" }, layout: :ATK
  text str: data.def.map { |s| "#{s} DEF" }, layout: :DEF

  svg file: 'example.svg'

  text str: ProjectOcelot::VERSION, layout: :version

  build(:proofs) do
    safe_zone
    cut_zone
  end

  save format: :png

  build(:pnp) do
    save_sheet prefix: 'pnp_sheet_',
               trim: '0.125in',
               rows: 3, columns: 3
  end
end
