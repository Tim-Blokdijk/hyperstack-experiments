class AspectsCat < HyperComponent

  before_mount do

  end

  after_mount do

  end

  after_update do

  end

  render(DIV) do

    puts 'render cat'

    FORM() do
      INPUT(type: "radio", name: "cat", value: "cat")
      SPAN{'Cat'}
      BR()
      INPUT(type: "radio", name: "cat", value: "dog")
      SPAN{'Dog'}
      BR()
      INPUT(type: "radio", name: "cat", value: "hamster")
      SPAN{'Hamster'}
      BR()
    end

  end

end