module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_profile, only: [:show, :update, :destroy]
      
      def index
        @profile = current_api_v1_user.profile
        render json: @profile
      end

      def show
        render json: @profile
      end

      def create
        @profile = Profile.create(profile_params)
        render json: @profile, status: :created
      end

      def update
        @profile.update(profile_params)
        render json: @profile
      end

      def destroy
        @profile.destroy
        render json: { message: 'deleted' }
      end

      private

      def set_profile
        @profile = Profile.find(params[:id])
      end

      def profile_params
        params.require(:profile).permit(:name, :kind).merge(user: current_api_v1_user)
      end
    end
  end
end
