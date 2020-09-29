# frozen_string_literal: true

# Monkey patch the generated Bindings for the swagger Event model

Rails.application.config.to_prepare do

  # If we're running the task to generate model bindings, there's nothing yet
  # to monkey patch, so bail.
  next if RakeUtils.running_task?(/generate_model_bindings/)

  Api::V0::Bindings::Event.class_exec do
    def valid_data?
      data&.valid?
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
