class AspectsAge < HyperComponent

  before_mount do
    puts 'before age mount'
  end

  after_mount do
    puts 'after age mount'
    AgeOperations::Get.run
    puts 'AgeOperations::Get.run'
    create_nouislider
  end

  after_update do
    puts 'after update'
    slider = Native(`document.getElementById('range')`)
    if slider
      if (slider.noUiSlider.get()).size ==  AspectStore.age_slider.size
        slider.noUiSlider.set(AspectStore.age_slider)
      else
        slider.noUiSlider.destroy()
        create_nouislider
      end
    end
  end

  render(DIV) do

    puts 'render age'

    puts 'range'
    DIV(id: :range)
    FORM(style: {marginTop: '50px'}) do
      AspectStore.state.age_criteria.each_with_index do |criteria, index|
        DIV do
          SPAN(style: {display: 'inline-block', width: '200px', textAlign: 'right', paddingRight: '10px'}){'Leeftijd van '+ criteria[0].to_s + ' tot '+ criteria[1].to_s + ':'}
          BUTTON(disabled: (criteria[1] - criteria[0] < 3 ), style: {marginRight: '10px'}){'✀'}.on(:click) { |event|
            event.prevent_default
            age_from, age_to, rationale, score = AspectStore.state.age_criteria[index]

            new_age = age_from + ((age_to - age_from)/2).round
            AspectStore.mutate.age_criteria.insert(index, [AspectStore.state.age_criteria[index][0], new_age, AspectStore.state.age_criteria[index][2], AspectStore.state.age_criteria[index][3]])
            AspectStore.mutate.age_criteria[index + 1][0] = new_age + 1

            AgeOperations::Send(age_criteria: AspectStore.state.age_criteria)
          }
          SPAN(style: {paddingRight: '10px'}){'Score:'}
          INPUT(type: 'checkbox', checked: (criteria[3].blank?)).on(:change) do |event|
            event.prevent_default
            if criteria[3].blank?
              AspectStore.mutate.age_criteria[index][3] = 0
            else
              AspectStore.mutate.age_criteria[index][3] = nil
            end
            AgeOperations::Send(age_criteria: AspectStore.state.age_criteria)
          end
          if criteria[3].present?
            INPUT(disabled: criteria[3].blank?, style: {width: '67px', marginRight: '10px'},type: 'number', value: criteria[3]).on(:change) do |event|
              event.prevent_default
              AspectStore.mutate.age_criteria[index][3] = event.target.value
              AgeOperations::Send(age_criteria: AspectStore.state.age_criteria)
            end
            STYLE do
              if criteria[3].to_i > 0
                '#range div:nth-of-type(' + (index + 1).to_s + ').noUi-connect { background: green; }'
              elsif criteria[3].to_i < 0
                '#range div:nth-of-type(' + (index + 1).to_s + ').noUi-connect { background: yellow; }'
              end
            end
          else
            SPAN(style: {paddingRight: '10px'}){'Uitgesloten'}
            STYLE do
              '#range div:nth-of-type(' + (index + 1).to_s + ').noUi-connect { background: red; }'
            end
          end
          SPAN(style: {paddingRight: '10px'}){'Omschrijving:'}
          INPUT(value: criteria[2], style: {marginRight: '10px'}).on(:change) do |event|
            event.prevent_default
            AspectStore.mutate.age_criteria[index][2] = event.target.value
            AgeOperations::Send(age_criteria: AspectStore.state.age_criteria)
          end
          #SPAN(style: {paddingRight: '10px'}){'Verwijderen:'}
          BUTTON{'✘'}.on(:click) do |event|
            event.prevent_default
            if (AspectStore.state.age_criteria.size - 1) == index
              # Last element in age_criteria
              alert 'tim'
              AspectStore.mutate.age_criteria[index - 1][1] = AspectStore.state.age_criteria[index][1]
              AspectStore.mutate.age_criteria.delete_at(index)
            else
              # Not the last element
              age = AspectStore.state.age_criteria[index][0]
              AspectStore.mutate.age_criteria.delete_at(index)
              AspectStore.mutate.age_criteria[index][0] = age
            end
            AgeOperations::Send(age_criteria: AspectStore.state.age_criteria)
          end
        end
      end
    end

  end

  def create_nouislider
    puts 'create nouislider'

    element = `document.getElementById('range')`
    slider = Native(`window.noUiSlider`).create(element, {
      range: {
        min: 16,
        max: 120
      },
      start: AspectStore.age_slider,
      connect: (AspectStore.age_slider.size + 1).times.map { true },
      padding: [ 0, 1 ],
      step: 1,
      margin: 1,
      behaviour: 'tap-drag',
      tooltips: true,
      format: {
        to: ->(value){
          value.to_i.round.to_s + ' | ' + (value.to_i + 1).round.to_s
        },
        from: ->(value){
          value.to_i
        }
      },
      pips: {
        mode: 'count',
        values: 12,
        stepped: true
      }
    })

    slider.on('change', ->(values, handle, unencoded, tap, positions){
      if AspectStore.age_slider != unencoded.map(&:round)
        unencoded.map(&:round).each_with_index do |age, index|
          AspectStore.mutate.age_criteria[index][1] = age
          AspectStore.mutate.age_criteria[index + 1][0] = (age + 1)
        end
        puts 'slider change'
        AgeOperations::Send(age_criteria: AspectStore.state.age_criteria)
      end
    })

  end

end