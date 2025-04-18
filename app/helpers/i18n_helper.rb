module I18nHelper
  def export_translations_to_js(namespace)
    translations = I18n.t(namespace)
    javascript_tag "window.I18n = window.I18n || {}; window.I18n['#{namespace}'] = #{translations.to_json.html_safe};"
  end
end
