class User < ApplicationRecord
    has_secure_password
    has_many :questions, dependent: :nullify # will set the user_id on all the questions to null
    has_many :answers, dependent: :nullify
    # provides user authentication features on the model it is called in.
    # requires a column named 'password_digest' and the gem 'bcrypt'
    # - it will add two attribute accessors for 'password' and 'password_confirmation'
    # - It will add a presence validation for the 'password' field
    # - It will save passwords assigned to 'password' using bcrypt to hash and store it in the 'password_digest' column meaning that we will never store plain textpasswords.
    # - It will add a method named 'authenticate' to verify a user's password. If called with the correct password, it will return the user. Otherwise, it will return 'false'
    # - The attribute accessor 'password_confirmation' is optional. If it is present, a validation will be added to verify that is identical to 'password'

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i #email validation regex

    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

    def full_name
        "#{first_name} #{last_name}".strip
    end
end
