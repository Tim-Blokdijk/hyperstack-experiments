module AgeOperations

  class AgeBase < Hyperstack::ServerOp
    param :acting_user, nils: true
    dispatch_to { Hyperstack::Application }

    def cachedleeftijd
      Rails.cache.fetch('age_criteria')
    end

  end

  class Get < AgeBase
    outbound :age_criteria

    step do
      puts 'AgeOperations::Get'
      params.age_criteria = cachedleeftijd
    end

  end

  class Send < AgeBase
    param :age_criteria

    step do
      puts 'AgeOperations::Send'
      Rails.cache.write('age_criteria', params.age_criteria)
    end

  end

end