module TrackedViews
  extend ActiveSupport::Concern

  included do
    has_many :user_actions, as: :target
  end

  def seen?
    !!read_attribute(:seen_at)
  end

  module ClassMethods

    def with_viewstate(user)
      join_statement = <<END
  LEFT OUTER JOIN user_actions ON
target_id = #{table_name}.id AND target_type = #{ActiveRecord::Base.connection.quote(self.model_name.to_s)} AND user_id = #{user.id}
END
      joins(join_statement).select("#{table_name}.*, user_actions.created_at as seen_at")
    end
  end
end