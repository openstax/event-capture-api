# frozen_string_literal: true

# Monkey patch the generated Bindings for the swagger Event model

Rails.application.config.to_prepare do

  # If we're running the task to generate model bindings, there's nothing yet
  # to monkey patch, so bail.
  next if RakeUtils.running_task?(/generate_model_bindings/)

  Api::V0::Bindings::Events.class_exec do
    alias_method :original_valid?, :valid?
    def valid?
      original_valid? && events.all?(&:valid?)
    end

    alias_method :original_list_invalid_properties, :list_invalid_properties
    def list_invalid_properties
      event_invalid_properties = events.map_with_index do |event,ii|
        event.list_invalid_properties.map do |message|
          "Event [#{ii}]: #{message}"
        end
      end.flatten

      original_list_invalid_properties + event_invalid_properties
    end
  end

  Api::V0::Bindings::Event.class_exec do
    alias_method :original_valid?, :valid?
    def valid?
      original_valid? && data&.valid?
    end

    alias_method :original_list_invalid_properties, :list_invalid_properties
    def list_invalid_properties
      original_list_invalid_properties + (data&.list_invalid_properties || [])
    end

    def data=(data_object)
      *_, record_name = data_object[:type].split('.')
      swagger_class = swagger_class_for_record_name(record_name)
      @data = swagger_class.new(data_object)
    end

    def swagger_class_for_record_name(record_name)
      # memoizing in case constantize is not super fast
      @record_name_to_swagger_class_map ||= {}
      @record_name_to_swagger_class_map[record_name] ||= begin
        "Api::V0::Bindings::#{record_name.camelize}".constantize
      end
    end
  end
end
