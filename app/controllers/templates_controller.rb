class TemplatesController < ApplicationController
  def index
    @templates = current_user.templates
    @contact = Contact.tagged_with(params[:flag]).where(status: false).first
  end
  def new
    @template = Template.new(template_params)
  end

  def create
    @templates = current_user.templates
    p @template = Template.new(template_params)
    @template.user_id = current_user.id
    p @template
    @contact = Contact.where(status: false).first
    @signature = Signature.find_by(name: @template.category)
    @template.save
  end

  def edit
    @template = Template.find(params[:id])
  end

  def update
    @template = Template.find(params[:id])
    if @template.update_attributes(template_params)
      redirect_to templates_path
    else
      render :new
    end
  end

  def show
    @template = current_user.templates.find(params[:id])
    respond_to do |format|
      format.json { render json: {"description" => @template.description}}
      #format.js { render layout: false, content_type: 'text/javascript'}
    end
    return
  end

  def destroy
    Template.find(params[:id]).destroy
    redirect_to templates_path
  end

  private
  def template_params
    params.require(:template).permit(:title, :category, :paragraph, :description,:api_key,:user_id)
  end
end
