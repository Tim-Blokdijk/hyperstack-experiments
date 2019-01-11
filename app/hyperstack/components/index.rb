class Index < HyperComponent
  include Hyperstack::Router::Helpers

  before_mount do
    @client = Client.first
  end

  after_mount do

  end

  after_update do

  end

  render(DIV) do

    H1 { 'Searchprofiles' }

    DIV(style:{
      display: 'flex',
      flexWrap: 'wrap',
    }) do
      (@client.search_profiles + [SearchProfile.new(name: 'Name', description: 'Describe what sort of house you\'re looking for.')]).each do |search_profile|
        DIV(style: {border: '1px solid black', borderRadius: '5px', margin: '5px', padding: '5px', minWidth: '20em', maxWidth: '30em'}) do
          DIV {
            B { 'Name: ' }
            if search_profile.id.nil?
              INPUT(type: :text, value: search_profile.name).on(:change) do |evt|
                search_profile.name = evt.target.value
              end
            else
              SPAN { search_profile.name }
            end
          }
          DIV {
            DIV { B {'Description:'} }
            if search_profile.id.nil?
              TEXTAREA(style: {width: '100%', height: '15em'}, value: search_profile.description).on(:change) do |evt|
                search_profile.description = evt.target.value
              end
            else
              SPAN { search_profile.description }
            end
          }
          DIV {
            if search_profile.id.nil?
              BUTTON { 'Save' }.on(:click) do
                search_profile.client = @client
                search_profile.save
              end
            else

            end
          }
          if @client.search_profiles.include? search_profile #.new_record? # is not implemented..
            DIV { Link("/search/#{search_profile.id}", active_class: :selected) { 'Show' } }
            DIV do A { 'Delete' }.on(:click) {
              search_profile.destroy if confirm('Are you sure you wan\'t to delete this search profile?') }
            end unless search_profile.id == 1
          end
        end
      end
    end

  end

end