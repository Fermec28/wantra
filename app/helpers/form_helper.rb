module FormHelper
  def field_error(model, field)
    return unless model.errors[field].present?

    content_tag :p, model.errors[field].first,
      class: "text-sm text-red-600 mt-1"
  end
end
