class Api::RewardsController < ApplicationController
    def create
        Rails.logger.info "Received reward creation request with params: #{params.inspect}"
            
        response = TremendousService.send_reward(
            to: reward_params[:to],
            email: reward_params[:recipient_email],
            from: reward_params[:from],
            message: reward_params[:message]
        )
    
        if response&.code == 201
          Rails.logger.info "Reward successfully sent."
          render json: { status: 'success', message: 'Reward sent successfully' }, status: :created
        else
          Rails.logger.error "Failed to send reward. Response: #{response&.body || 'No response'}"
          render json: { status: 'error', message: JSON.parse(response&.body || '{}') }, status: :unprocessable_entity
        end
    end

    private

    def reward_params
        params.require(:reward).permit(:to, :from, :message, :recipient_email)
    end
end