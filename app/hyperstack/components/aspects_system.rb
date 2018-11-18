class AspectsSystem < HyperComponent

  before_mount do

  end

  after_mount do

  end

  after_update do

  end

  render(DIV) do

    puts 'render system'

    FORM() do
      INPUT(type: "radio", name: "system", value: "cat")
      SPAN{'x64'}
      BR()
      INPUT(type: "radio", name: "system", value: "dog")
      SPAN{'Power'}
      BR()
      INPUT(type: "radio", name: "system", value: "hamster")
      SPAN{'Arm'}
      BR()
    end

  end

end