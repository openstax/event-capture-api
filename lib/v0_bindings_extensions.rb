# frozen_string_literal: true
 
# Monkey patch the generated Bindings for the swagger Event model

Rails.application.config.to_prepare do
  Api::V0::Bindings::Event.class_exec do
    def valid_data?
      data&.valid?
    end

    def data=(data_object)
      @data = case data_object.type
              when 'org.openstax.ec.nudged'
                Api::V0::Bindings::Nudge.new(data)
              end
    end
  end
end
