class LeadsController < ApplicationController
    
    def index
      @leads = Lead.all.order('created_at DESC')
    end
    
    def show
      @lead = Lead.find(params[:id])
    end
    
    def new
      @lead = Lead.new
    end
    
    def edit
      @lead = Lead.find(params[:id])
    end
    
    def create
      @lead = Lead.new(lead_params)
      
      if @lead.save
          redirect_to @lead
      else
          render 'new'
      end
    end
    
    def update
      @lead = Lead.find(params[:id])
      
      if @lead.update(lead_params)
          redirect_to @lead
      else
          render 'edit'
      end
    end
    
    def destroy
      @lead = Lead.find(params[:id])
      @lead.destroy
        
      redirect_to leads_path
    end
    
    private
    
    def lead_params
      params.require(:lead).permit(:name, :phone, :email, :location,
                                  :project, :square, :floor, :question,
                                  :region, :source, :online_request,
                                  :come_in_office, :phone_call, :status)
    end
    
end
