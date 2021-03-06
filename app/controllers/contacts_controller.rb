class ContactsController < ApplicationController

    before_action :require_logged_in_user
    before_action :set_contact, only: [:show, :edit, :uptate, :destroy]
  
  
    def index
      @contacts = current_user.contacts
    end
  
    def show
    end

    def new
      @contact = Contact.new
    end
  
    def edit
    end

    def create
      @contact = current_user.contacts.build(contact_params)

      respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was succesfully created'}
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new}
        format.json { render json: @contact.errors, status: :unprocessable_entity}
      end
    end
  end
    
    def update
     if @contact.uptate(contact_params)
       format.html { redirect_to @contact, notice: 'Contact was succesfully created'}
       format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new}
        format.json { render json: @contact.errors, status: :unprocessable_entity}
      end
    end
  end
  
    def destroy
      @contact.destroy
      respond_to do |format|
        format.html { redirect_to contacts_url, notice: 'Contact was succesfully created'}
        format.json { head :no_content }
    end
  end
  
    private
      def set_contact
        @contact = current_user.contacts.find(params[id])
      end

      def contact_params
        params.require(:contact).permit(:name, :phone)
      end
  end