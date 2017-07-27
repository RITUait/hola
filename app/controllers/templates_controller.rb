class TemplatesController < ApplicationController
def index
 @templates = Template.all
end
   
def new
  @template =  Template.new
  
end

def create
 @template = Template.new(template_params)
 if @template.save
   redirect_to root_path
 else 
   render :new
end
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
@template = Template.first
end

def destroy
  Template.find(params[:id]).destroy
  redirect_to templates_path
end

private
def template_params
 params.require(:template).permit(:title, :description)
end
end
