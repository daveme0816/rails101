class GroupsController < ApplicationController
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

    def index
        @groups = Group.all
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        @group.user = current_user
        if @group.save
            redirect_to groups_path
        else
            render :new
        end

    end

    def show
        @group = Group.find(params[:id])
    end

    def edit
    end
    
    def update
        if @group.update(group_params)
          flash[:notice] = "Group was successfully updated"
          redirect_to groups_path
        else
          flash[:error] = "Something went wrong"
          render 'edit'
        end
    end

    def destroy
        if @group.destroy
            flash[:alert] = 'Object was successfully deleted.'
            redirect_to groups_path
        else
            flash[:error] = 'Something went wrong'
            redirect_to groups_path
        end
    end
    
    

    private

    def find_group_and_check_permission
        @group = Group.find(params[:id])
    
        if current_user != @group.user
          redirect_to root_path, alert: "You have no permission."
        end
    end

    def group_params
        params.require(:group).permit(:title, :description)
        
    end
end
