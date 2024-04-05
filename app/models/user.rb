class User < ApplicationRecord
    include Devise::JWT::RevocationStrategies::JTIMatcher

    devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

    belongs_to :merchant
    has_many :to_dos


end
