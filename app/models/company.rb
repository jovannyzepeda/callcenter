# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  nombre            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  eliminado         :boolean          default("0")
#  security          :string(255)
#  port              :integer
#  password          :string(255)
#  username          :string(255)
#  address           :string(255)
#

class Company < ApplicationRecord
	  has_attached_file :logo, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  	validates :nombre, :presence => true
  	validates :security, presence: true
  	validates :port, presence: true
  	validates :password, presence: true
  	validates :username, presence: true
  	validates :address, presence: true
  	has_many :templates
  	has_many :campaign
  	has_many :usercompany
  	has_many :users, through: :usercompany
    has_many :signempresas
    belongs_to :user
    before_save :encript

    private
    def encript
      self.password = Company.codificar("#{self.password}")
    end
    def self.codificar (texto, n=2) 
      resultado = '' 
      texto.each_char do |letra| 
          letra = ("#{letra}".ord + n).chr
          resultado = "#{resultado}#{letra}" 
      end 
      texto 
    end 
 
    def self.decodificar (texto, n=2) 
        resultado = '' 
        texto.each_char do |letra| 
            letra = ("#{letra}".ord - n).chr
            resultado = "#{resultado}#{letra}" 
        end 
        texto  
    end 
end
