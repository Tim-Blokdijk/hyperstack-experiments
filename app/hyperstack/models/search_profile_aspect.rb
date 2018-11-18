class SearchProfileAspect < ApplicationRecord

  belongs_to :search_profile
  belongs_to :aspect

  serialize :data

end