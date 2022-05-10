module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_record, only: [:show, :update, :destroy]

      # GET /users
      def index
        if current_user.has_role? :admin
          render json: User.all
        else
          puts "Access denied"
        end
      end
      private

      # Use callbacks to share common setup or constraints between actions.
      def set_record
        @record = current_user.records.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def record_params
        params.require(:record).permit(:title, :year, :artist_id)
      end
    end
  end
end