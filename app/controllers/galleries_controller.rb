class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.all
  end
  
  def show
    @gallery = Gallery.find(id_params)
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      flash[:notice] = "Successfully created gallery."
      redirect_to @gallery
    else
      render :action => 'new'
    end
  end
  
  def edit
    @gallery = Gallery.find(id_params)
  end
  
  def update
    @gallery = Gallery.find(id_params)
    if @gallery.update_attributes(gallery_params)
      flash[:notice] = "Successfully updated gallery."
      redirect_to gallery_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @gallery = Gallery.find(id_params)
    @gallery.destroy
    flash[:notice] = "Successfully destroy gallery."
    redirect_to galleries_url
  end
  
  private
  
  
   def gallery_params
     params.require(:user).permit(:name)
   end
   
   def id_params
     params.require(:id).permit(:name)
   end
   
end