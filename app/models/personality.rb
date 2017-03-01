class Personality
    
    include ActiveModel::Model
    
    # Formで使用するプロパティを定義する
    attr_accessor :ans1, :ans2 ,:ans3
    
    # Validationを定義する
    validates :ans1, presence: true, length: { minimum: 800 } 
    validates :ans2, presence: true, length: { minimum: 800 } 
    validates :ans3, presence: true, length: { minimum: 800 } 
    
end
