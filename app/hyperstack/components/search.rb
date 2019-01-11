class Search < HyperComponent
  include Hyperstack::Router::Helpers

  before_mount do
    @client = Client.first
    @search_profile = @client.search_profiles.find(match.params[:id]) # .find is not returning a SearchProfile record??
    alert ':id as provided in url: ' + match.params[:id]
    alert '@search_profile is a: ' + @search_profile.class.name
    alert 'first element in @search_profile is a: ' + @search_profile.first.class.name

    @search_profile = @search_profile.first # HACK!
  end

  after_mount do

  end

  after_update do

  end

  render(DIV) do

    H1 {
      Link('/') { 'Searchprofiles ' }
      SPAN { ' > ' }
      SPAN { @search_profile.name }
    }

    P {
      STRONG { 'Description: ' }
      SPAN { @search_profile.description }
    }

  end

end