require 'rails_helper'

RSpec.describe "XAPI endpoint", type: :request do
  describe "POST /xapi" do
    context "with valid xAPI event" do
      let(:valid_xapi_event) do
        {
          "actor": {
            "name": "John Doe",
            "mbox": "mailto:johndoe@example.com"
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

      it "saves the xAPI event to Kafka" do
        expect {
          post "/xapi", params: valid_xapi_event.to_json
        }.to change { KafkaProducer.messages.count }.by(1)
      end

      it "responds with HTTP status 200" do
        post "/xapi", params: valid_xapi_event.to_json
        expect(response).to have_http_status(200)
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
        expect {
          post "/xapi", params: invalid_xapi_event.to_json
        }.not_to change { KafkaProducer.messages.count }
      end

      it "responds with HTTP status 400" do
        post "/xapi", params: invalid_xapi_event.to_json
        expect(response).to have_http_status(400)
      end
    end
  end
end
