module ApplicationHelper
    def format_date(date, format = :default)
        I18n.l(date, format: format) if date.present?
    end
    def format_curr(value)
        number_to_currency(value, unit: "R$", separator: ",", delimiter: ".", format: "%u %n", precision: 2)
    end  
end
