class Criterium < ApplicationRecord

  belongs_to :search_profile
  belongs_to :aspect, optional: true

  serialize :select

end