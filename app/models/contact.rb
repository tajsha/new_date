class Contact
   include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :email, :content

    validates_length_of :content, :maximum => 500

    def initialize(attributes={})
      attributes && attributes.each do |name, value|
        send("#{name}=", value) if respond_to? name.to_sym 
      end
    end

    def persisted?
      false
    end
  end