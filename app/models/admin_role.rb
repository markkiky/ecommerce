class AdminRole < ApplicationRecord
    belongs_to :role
    belongs_to :admin


    # creates a customer bookin
    def self.make(admin_id, role_id)
        if role_id.is_a?(Array)
            role_id.each do |role_id|
                @admin_role = AdminRole.find_or_create_by(:admin_id => admin_id, :role_id => role_id)
            end
        else
            @admin_role = AdminRole.find_or_create_by(:admin_id => admin_id, :role_id => role_id)
        end
        if @admin_role != nil
            return true
        elsif @admin_role == nil
            return false
        end
    end

    # removes a customer from a bookinn
    def self.remove(admin_id, role_id)
        @admin_role = AdminRole.find_by(:admin_id => admin_id, :role_id => role_id)
        @admin_role.destroy
    end
end
