class Association < ActiveRecord::Base
  attr_accessible :name,
                  :city,
                  :street,
                  :zip_code,
                  :email,
                  :association_board,
                  :county_court,
                  :association_register,
                  :bank_name,
                  :iban,
                  :bic,
                  :web
end
