module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!

      # GET /users
      def index
        if current_user.has_role? :admin
          render json: user_includes
        else
          render json: "Access denied"
        end
      end

      private

      def user_includes
        { records: current_user.records.all,
          users: User.all }
      end
    end
  end
end