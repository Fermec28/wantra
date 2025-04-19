module Budgets
  module Services
    Result = Struct.new(:success?, :budget)

    class BudgetCreator
      def initialize(user:, params:)
        @user = user
        @params = params.deep_dup
      end

      def call
        normalize_month
        resolve_tag

        @budget = @user.budgets.build(@params)

        if @budget.save
          Result.new(true, @budget)
        else
          Result.new(false, @budget)
        end
      end

      private

      def normalize_month
        @params[:month] = Date.parse("#{@params[:month]}-01") if @params[:month].present?
      end

      def resolve_tag
        tag_name = @params[:tag_name].strip.downcase
        tag = @user.tags.find_or_create_by(name: tag_name)
        @params[:tag_id] = tag.id
        @params.delete(:tag_name)
      end
    end
  end
end
