class Search < HyperComponent
  include Hyperstack::Router::Helpers

  before_mount do
    @client = Client.first
    @search_profile = @client.search_profiles.find(match.params[:id])
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