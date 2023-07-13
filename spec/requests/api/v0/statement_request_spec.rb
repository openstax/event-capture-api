require 'rails_helper'

include SchemaRegistryHelpers

RSpec.describe "XAPI endpoint", type: :request do
  before do
    use_fake_schema_registry
  end

  describe "POST /api/v0/xapi/statements" do
    context "with valid xAPI event" do
      let(:valid_xapi_event) do
        {
          "id": "ff817604-a59e-4a22-8b33-6e1d841cdafb",
          "actor": {
            "name": "John Doe",
            "mbox": "mailto:johndoe@example.com",
            "objectType": "Agent"
          },
          "verb": {
            "id": "http://example.com/verbs/completed",
            "display": {
              "en-US": "completed"
            }
          },
          "object": {
            "id": "http://example.com/activities/example",
            "objectType": "Activity",
            "definition": {
              "name": {
                "en-US": "Example Activity"
              }
            }
          }
        }
      end

      it "saves the xAPI event to Kafka" do
        expect(KafkaClient).to receive(:async_produce)
        post "/api/v0/xapi/statements", params: valid_xapi_event, as: :json
      end

      it "responds with HTTP status 201" do
        post "/api/v0/xapi/statements", params: valid_xapi_event, as: :json
        expect(response).to have_http_status(201)
      end

      it "saves an array of xAPI events to Kafka" do
        expect(KafkaClient).to receive(:async_produce).twice
        post "/api/v0/xapi/statements", params: [valid_xapi_event, valid_xapi_event], as: :json
        expect(response).to have_http_status(201)
      end

    end

    context "with invalid xAPI event" do
      let(:invalid_xapi_event) do
        {
          "actor": {
            "name": "John Doe"
          },
          "verb": {
            "id": "http://example.com/verbs/completed",
            "display": {
              "en-US": "completed"
            }
          },
          "object": {
            "id": "http://example.com/activities/example",
            "definition": {
              "name": {
                "en-US": "Example Activity"
              }
            }
          }
        }
      end

      it "does not save the xAPI event to Kafka" do
        post "/api/v0/xapi/statements", params: invalid_xapi_event, as: :json
        expect(KafkaClient).not_to receive(:async_produce)
      end

      it "responds with HTTP status 422" do
        post "/api/v0/xapi/statements", params: invalid_xapi_event, as: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
