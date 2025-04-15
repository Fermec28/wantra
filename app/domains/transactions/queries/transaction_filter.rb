module Transactions
  module Queries
    class TransactionFilter
      def initialize(relation, params)
        @relation = relation
        @params = params
      end

      def call
        filtered = @relation

        filtered = filtered.where(txn_kind: @params[:txn_kind]) if @params[:txn_kind].present?
        filtered = filtered.where(account_id: @params[:account_id]) if @params[:account_id].present?
        filtered = filter_by_tags(filtered, @params[:tag]) if @params[:tag].present?

        from = parse_date(@params[:from]) || 1.month.ago.to_date
        to   = parse_date(@params[:to])   || Date.today

        filtered.where(date: from..to).order(date: :desc, id: :desc)
      end

      private

      def filter_by_tags(relation, tag_params)
        tag_list = Array(tag_params).map(&:downcase)
        relation.joins(:tags).where(tags: { name: tag_list }).distinct
      end

      def parse_date(str)
        Date.parse(str) rescue nil
      end
    end
  end
end
