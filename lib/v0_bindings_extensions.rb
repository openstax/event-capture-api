# frozen_string_literal: true

# Monkey patch the generated Bindings for the swagger Event model

Rails.application.config.to_prepare do

  # Don't try to monkey patch classes if they haven't been generated yet;
  # and use 'next' instead of 'return' b/c this is called in a proc
  # if we use return it gives an 'unexpected return' error
  next if !Object.const_defined?("Api::V0::Bindings")

  Api::V0::Bindings::Event.class_exec do
    def valid_data?
      data&.valid?
    end

    def data=(data_object)
      @data = case data_object[:type]
              when 'org.openstax.ec.nudged_v1'
                Api::V0::Bindings::NudgedV1.new(data_object)
              end
    end
  end
end
