class Aspects < HyperComponent

  before_mount do
    puts 'before mount'
    @aspects = Aspect.all
  end

  after_mount do
    puts 'after mount'
  end

  after_update do
    puts 'after update'
  end

  render(DIV) do

    puts 'render'

    H2 { 'Aspecten' }

    @aspects.each do |aspect|
      TABLE(class: :responstable) do
        THEAD do
          TR do
            TH { aspect.name.capitalize }
          end
        end
        TBODY do
          TR do
            TD(class: :criteria) do
              if aspect.name == 'age'
                puts 'aspects age'
                AspectsAge()
              elsif aspect.name == 'cats_dogs_hamsters'
                AspectsCat()
              elsif aspect.name == 'system'
                AspectsSystem()
              end
            end
          end
        end
      end
    end

  end

end