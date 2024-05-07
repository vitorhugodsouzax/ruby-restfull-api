class Phone < ApplicationRecord
  belongs_to :contact, optional: true #phone pertence a contatos
  
end
