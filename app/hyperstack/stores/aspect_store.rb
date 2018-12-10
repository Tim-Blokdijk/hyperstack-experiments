class AspectStore
  include Hyperstack::Legacy::Store

  state age_criteria: [
    [16, 22, 'te jong', nil],
    [23, 25, 'jong', 0],
    [26, 28, 'jong volwasen', 10],
    [29, 34, 'volwassen', 0],
    [35, 38, 'ouder', -10],
    [39, 120, 'te oud', nil],
  ], reader: true, scope: :class

  def self.age_slider
    state.age_criteria.map{|age| age[1]}.first state.age_criteria.size - 1
  end

  receives AgeOperations::Get do |params|
    puts "receiving Operations::Get(#{params})"
    mutate.age_criteria params.age_criteria unless params.age_criteria.nil?
  end

  receives AgeOperations::Send do |params|
    puts "receiving Operations::Send(#{params})"
    mutate.age_criteria params.age_criteria unless params.age_criteria.nil?
  end

end