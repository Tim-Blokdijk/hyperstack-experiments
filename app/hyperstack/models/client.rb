class Client < ApplicationRecord

  has_many :search_profiles, dependent: :destroy

  validates :login,
            presence: true,
            length: { minimum: 2 }

end