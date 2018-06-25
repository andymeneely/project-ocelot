require 'squib'
require_relative 'version'

# data = Squib.xlsx file: 'data/game.xlsx', sheet: 0

data = Squib.csv data: <<~EOCSV
Name,Action 1 Name,Action 1 Subactions
Paramedic,Spring,3
EOCSV

Squib::Deck.new(cards: data.nrows, width: '70mm', height: '120mm') do
  background color: :white
  use_layout file: 'layouts/characters.yml'

  text str: data.name, layout: :name

  text str: data.action_1_name.map { |s| "#{s} ATK" }, layout: :ATK

  # text str: data.atk.map { |s| "#{s} ATK" }, layout: :ATK
  # text str: data.def.map { |s| "#{s} DEF" }, layout: :DEF

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
