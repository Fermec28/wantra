module AccountsHelper
  def currency_options_for_select
    Money::Currency.table.map do |_, data|
      [ "#{data[:name]} (#{data[:symbol]})", data[:iso_code] ]
    end.sort_by { |label, _| label }
  end
end
