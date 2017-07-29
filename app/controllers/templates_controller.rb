class TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end
   
  def new
    @template =  Template.new
    @signatures = Signature.all
    
    p  @contact = Contact.where(status: false).first
  end

  def create
    @template = Template.new(template_params)
    @contact = Contact.where(status: false).first
    @signature = Signature.find_by(name: @template.category)
    if @template.save
      @contact.update(status: true)
      SignatureMailer.test_email(@contact.id, @signature.id,@template.id).deliver_now
    end
    redirect_to new_template_path
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
    @template = Template.last
  end

  def destroy
    Template.find(params[:id]).destroy
    redirect_to templates_path
  end

  private
  def template_params
    params.require(:template).permit(:category, :description)
  end
end
