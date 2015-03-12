class ContactMailer < ActionMailer::Base
  default :from => "no-reply@areyoutaken.com"  

    def new_contact(contact)
      @contact = contact
      mail(to: 'cwilson05@gmail.com', subject: 'Contact us Form')
    end

  end