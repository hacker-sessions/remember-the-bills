module Api
  module V1
    class RemindersController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_reminder, only: [:show, :update, :destroy]

      def index
        @reminders = current_api_v1_user.reminders
        render json: @reminders
      end

      def show
        render json: @reminder
      end

      def create
        @reminder = Reminder.create(reminder_params)
        render json: @reminder, status: :created
      end

      def update
        @reminder.update(reminder_params)
        render json: @reminder
      end

      def destroy
        @reminder.destroy
        render json: { message: 'deleted' }
      end

      private

      def set_reminder
        @reminder = Reminder.find(params[:id])
      end

      def reminder_params
        params.require(:reminder).permit(:label, :due_date, :status, :amount, :recurrent).merge(user: current_api_v1_user)
      end
    end
  end
end
