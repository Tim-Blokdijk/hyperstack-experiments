class App < HyperComponent
  
  before_mount do
    @client = Client.first
    @search_profile = @client.search_profiles.first
  end

  render(DIV) do
    H2 { 'Criteria' }

    TABLE(class: :responstable) do
      THEAD do
        TR do
          TH { 'Id' }
          TH { 'Selector' }
          TH { 'Score' }
          TH { 'Rationale' }
          TH { 'Active' }
          TH { 'Aspect' }
        end
      end
      TBODY do
        @search_profile.criteria.each do |criterium| # .order(score: :desc)
          TR do
            TD { criterium.id.to_s }
            TD { criterium.select.inspect }
            TD { criterium.score.to_s }
            TD { criterium.rationale }
            TD { criterium.active.to_s }
            TD { (criterium.aspect ? criterium.aspect.id.to_s : 'nill') }
          end
        end
      end
    end
  end

end