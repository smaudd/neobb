module ApplicationHelper
    def admin?
        current_user&.role == 'admin'
    end

    def moderator?
        current_user&.role == 'mod' || current_user&.role == 'admin'
    end

    def member?
        current_user&.role == 'member' || current_user&.role == 'mod' || current_user&.role == 'admin'
    end
end
