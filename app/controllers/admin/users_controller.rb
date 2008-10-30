class Admin::UsersController < Admin::BaseController
  def index
    @users = User.paginate :page => params[:page], :per_page => 20
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:notice] = '创建成功'
      redirect_to [:admin, @user]
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes params[:user]
      flash[:notice] = '更新成功'
      redirect_to [:admin, @user]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admin_users_path
  end
end
