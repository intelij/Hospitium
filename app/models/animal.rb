class Animal < ActiveRecord::Base
  CONSUMER_KEY = 'Is9pdOhRRNhx95wGBiWg'
  CONSUMER_SECRET = 'D2WLDX0Fh9EOGAhBJSQFkKs1U2c3ET2a5z2t9JZCrM'
  OPTIONS = {:site => "http://api.twitter.com", :request_endpoint => "http://api.twitter.com"}
  
  has_paper_trail
  has_attached_file :image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-static', :styles => { :large => "900x900>", :medium => "300x300>", :thumb => "140x140>" }
  has_attached_file :second_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-static', :styles => { :large => "900x900>", :medium => "300x300>", :thumb => "140x140>" }
  has_attached_file :third_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-static', :styles => { :large => "900x900>", :medium => "300x300>", :thumb => "140x140>" }
  belongs_to :organization
  belongs_to :species
  belongs_to :shelter
  belongs_to :animal_color
  belongs_to :animal_sex
  belongs_to :spay_neuter
  belongs_to :biter
  belongs_to :status
  has_many :animal_weights
  has_many :adopt_animals
  has_many :adoption_contacts, :through => :adopt_animals
  has_many :relinquish_animals
  has_many :relinquishment_contacts, :through => :relinquish_animals
  
  
  before_create :create_uuid
  after_update :send_public_tweet
  validates_presence_of :name, :date_of_intake, :organization, :species, :animal_color, :biter, :spay_neuter, :animal_sex, :status
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  
  # settings for rails admin views
  # rails_admin do
  #   show do
  #     field :name
  #     field :previous_name
  #     field :status
  #     field :public
  #     field :species
  #     field :birthday
  #     field :animal_sex
  #     field :animal_color
  #     field :spay_neuter
  #     field :biter
  #     field :date_of_intake
  #     field :date_of_well_check
  #     field :organization
  #     field :shelter
  #     field :special_needs
  #     field :diet
  #     field :adopted_date
  #     field :deceased
  #     field :deceased_reason
  #   end
  #   create do
  #     field :name do
  #       help 'Required - the animals current name.'
  #     end
  #     field :previous_name do
  #       help 'Optional - any previous names the animal may have had.'
  #     end
  #     field :status
  #     field :public, :boolean do
  #       help 'Optional - check to make the animal appear on our adopt list. Public animals must be available for adoption.'
  #     end
  #     field :species do
  #       help 'Required - if the species you need is not listed, click "Create species" above.'
  #     end
  #     field :birthday
  #     field :animal_sex
  #     field :animal_color do
  #       help 'Required - if the animal color you need is not listed, click "Create animal color" above.'
  #     end
  #     field :spay_neuter
  #     field :biter
  #     field :date_of_intake
  #     field :date_of_well_check do
  #       help 'Optional - date of first vet visit.'
  #     end
  #     field :organization
  #     field :shelter do
  #       help 'Optional - if the shelter you need is not listed, click "Create shelter" above.'
  #     end
  #     field :special_needs
  #     field :diet
  #     field :adopted_date
  #     field :deceased
  #     field :deceased_reason
  #     field :image, :paperclip_file
  #     field :second_image, :paperclip_file
  #     field :third_image, :paperclip_file
  #     group :animal_weights
  #   end
  #   edit do
  #     field :name do
  #       help 'Required - the animals current name.'
  #     end
  #     field :previous_name do
  #       help 'Optional - any previous names the animal may have had.'
  #     end
  #     field :status
  #     field :public, :boolean do
  #       help 'Optional - check to make the animal appear on our adopt list. Public animals must be available for adoption.'
  #     end
  #     field :species do
  #       help 'Required - if the species you need is not listed, click "Create species" above.'
  #     end
  #     field :birthday
  #     field :animal_sex
  #     field :animal_color
  #     field :spay_neuter
  #     field :biter
  #     field :date_of_intake
  #     field :date_of_well_check do
  #       help 'Optional - date of first vet visit.'
  #     end
  #     field :organization
  #     field :shelter do
  #       help 'Optional - if the shelter you need is not listed, click "Create shelter" above.'
  #     end
  #     field :special_needs
  #     field :diet
  #     field :adopted_date
  #     field :deceased
  #     field :deceased_reason
  #     field :image, :paperclip_file
  #     field :second_image, :paperclip_file
  #     field :third_image, :paperclip_file
  #     group :animal_weights
  #   end
  #   list do
  #     field :name
  #     field :previous_name
  #     field :species
  #     field :status
  #     field :animal_sex
  #     field :biter
  #     field :animal_color
  #     field :spay_neuter
  #     field :public
  #     field :shelter
  #     field :birthday
  #     field :date_of_intake
  #     field :date_of_well_check
  #     field :deceased
  #     field :adopted_date
  #     field :created_at
  #     field :updated_at
  #     # exclude_fields :uuid, :age, :sex, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :second_image, :second_image_file_name,
  #     #   :second_image_content_type, :second_image_file_size, :second_image_updated_at, :third_image, :third_image_file_name,
  #     #     :third_image_content_type, :third_image_file_size, :third_image_updated_at, :organization, :deceased_reason, :diet, :special_needs
  #   end
  # end
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def send_public_tweet
    if self.public == 1
      account = TwitterAccount.find_by_user_id(1)
      Twitter.configure do |config|
        config.consumer_key = TwitterAccount::CONSUMER_KEY
        config.consumer_secret = TwitterAccount::CONSUMER_SECRET
        config.oauth_token = account.oauth_token
        config.oauth_token_secret = account.oauth_token_secret
      end
      client = Twitter::Client.new
      #begin
      link = TwitterAccount.shorten_link("http://hospitium.co/animals/#{self.uuid}")
      client.update("#{self.name} is ready for adoption at #{link}")
      return true
    end
  end
  
  def calculate_animal_age
    age = (Time.now.year - self.birthday.year).to_s + " years"
    if age == "0 years"
      age = (Time.now.month - self.birthday.month).to_s + " months"
      if age == "0 months"
        age = (Time.now.day - self.birthday.day).to_s + " days"
      end
    end
    return age
  end
  
  def formatted_deceased_date
    age = self.deceased.strftime("%a, %b %e at %l:%M")
    return age
  end
  
  def formatted_intake_date
    age = self.date_of_intake.strftime("%a, %b %e at %l:%M")
    return age
  end
  
  def formatted_well_date
    age = self.date_of_well_check.strftime("%a, %b %e at %l:%M")
    return age
  end
  
  
end
