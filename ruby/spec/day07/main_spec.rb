RSpec.describe 'main.rb' do
  it 'finds a solution' do
    expect(`ruby src/day07/main.rb --input=../input/day07/example.txt --brightness=shiny --color=gold`).to eq(
      <<~EXPECTED
        Possible outer containers: 4
        Required inner containers: 32
      EXPECTED
    )
  end
end
