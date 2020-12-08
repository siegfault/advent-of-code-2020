RSpec.describe 'main.rb' do
  it 'finds a solution' do
    expect(`ruby src/day07/main.rb --input=input/day07/example.txt --brightness=shiny --color=gold`).to eq("4\n")
  end
end
