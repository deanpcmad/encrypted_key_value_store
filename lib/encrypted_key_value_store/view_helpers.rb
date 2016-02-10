module EncryptedKeyValueStore
  module ViewHelpers

    def ekvs_label(group, field)
      "<label for='#{group}_#{field}'>#{field.titleize}</label>".html_safe
    end

    def ekvs_field(group, field, options = {})
      # default = I18n.t("shoppe.settings.defaults")[field.to_sym]
      # value = (params[:settings] && params[:settings][field]) || Shoppe.settings[field.to_s]
      # value = params[:settings] && params[:settings][field]
      # value = KeyValuePair params[group][field]
      value = KeyValuePair.find_by(group: group, name: field).try(:value)
      type = options[:type] || "string"
      case type
      when "boolean"
        String.new.tap do |s|
          value = options[:default] if value.blank?
          s << "<div class='radios'>"
          s << radio_button_tag("#{group}[#{field}]", 'true', value == true, id: "#{group}_#{field}_true")
          s << label_tag("#{group}_#{field}_true", "Affirmative")
          s << radio_button_tag("#{group}[#{field}]", 'false', value == false, id: "#{group}_#{field}_false")
          s << label_tag("#{group}_#{field}_false", "Negative")
          s << "</div>"
        end.html_safe
      else
        text_field_tag "#{group}[#{field}]", value, options.merge(placeholder: options[:default], class: options[:class] || "text")
      end
    end

  end
end