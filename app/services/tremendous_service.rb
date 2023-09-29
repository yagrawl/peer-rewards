class TremendousService
    BASE_URL = 'https://testflight.tremendous.com/api/v2'.freeze
    HEADERS = {
      "Authorization" => "Bearer #{Rails.application.credentials.dig(:tremendous, :api_key)}",
      "Content-Type" => "application/json"
    }.freeze
  
    def self.send_reward(to:, email:, from:, message:)
        payload = build_payload(to: to, email: email, from: from, message: message)
        Rails.logger.info "Preparing to send reward to #{to} from #{from} with payload #{payload.to_json}."
    
        begin
          response = HTTParty.post("#{BASE_URL}/orders", headers: HEADERS, body: payload.to_json)
          Rails.logger.info "HTTParty response: #{response.body}"
          response
        rescue => e
          Rails.logger.error "Failed to send reward due to #{e.class.name}: #{e.message}"
          nil
        end
    end
  
    private
  
    def self.build_payload(to:, email:, from:, message:, campaign_type: "default")
      campaign_id = TREMENDOUS_CONFIG['campaign_ids'][campaign_type] || TREMENDOUS_CONFIG['campaign_ids']['default']

      {
        payment: {
          funding_source_id: "BALANCE"
        },
        rewards: [
          {
            campaign_id: campaign_id,
            value: {
              denomination: 1.00,
              currency_code: "USD"
            },
            delivery: {
              method: "EMAIL"
            },
            recipient: {
              name: to,
              email: email
            }
          }
        ]
      }
    end
  end
  