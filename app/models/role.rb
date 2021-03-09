class Role < ApplicationRecord
    has_many :admin_roles
    has_many :admins, through: :admin_roles
end
