class SearchProfile < ApplicationRecord

  belongs_to :client
  has_many :search_profile_aspects, dependent: :destroy
  has_many :aspects, through: :search_profile_aspects

end
