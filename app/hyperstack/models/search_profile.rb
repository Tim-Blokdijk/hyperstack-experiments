class SearchProfile < ApplicationRecord

  belongs_to :client
  has_many :search_profiles_aspects, dependent: :destroy
  has_many :aspects, through: :search_profile_aspects
  has_many :criteria, dependent: :destroy

  before_destroy :destroyable?

  def destroyable?
    errors[:base] << 'You can\'t destroy me!'
    throw :abort
  end

end