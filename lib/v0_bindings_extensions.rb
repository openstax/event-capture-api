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
      debugger
      @data = case data_object[:type]
              when 'org.openstax.ec.nudged_v1'
                Api::V0::Bindings::NudgedV1.new(data_object)
              end
    end
  end
end
