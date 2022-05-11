module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:show, :update, :destroy]
      # GET /users
      def index
        if current_user.has_role? :admin
          render json: user_includes
        else
          render json: is_admin
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
      end

      private

      def user_includes
        { artists: Artist.all,
          users: User.all,
          isAdmin: (current_user.has_role? :admin) }
      end

      def is_admin
        { isAdmin: (current_user.has_role? :admin) }
      end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email)
      end
    end
  end
end