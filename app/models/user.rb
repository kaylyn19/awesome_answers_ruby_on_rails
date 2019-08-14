class User < ApplicationRecord
    has_secure_password
    has_many :questions, dependent: :nullify # will set the user_id on all the questions to null
    has_many :answers, dependent: :nullify
    has_many :job_posts, dependent: :nullify
    has_many :likes, dependent: :nullify
    # `has_many` can take a `through` named argument to create a
    # many-to-many relationship via another `has_many` declaration.

    # We specify the name of another `has_many` with the `through`
    # option which corresponds to the join table between
    # the two tables that share the many-to-many relationship.

    # We must also provide a `source` named argument to specify
    # which model we're getting back from the many-to-many relationship.


    # has_many :questions, through: :likes # does not work because we
    # already have a has_many :questions on line 2
    has_many :liked_questions, through: :likes, source: :question # the foregin_key id is referring to the id from the question model

    # provides user authentication features on the model it is called in.
    # requires a column named 'password_digest' and the gem 'bcrypt'
    # - it will add two attribute accessors for 'password' and 'password_confirmation'
    # - It will add a presence validation for the 'password' field
    # - It will save passwords assigned to 'password' using bcrypt to hash and store it in the 'password_digest' column meaning that we will never store plain textpasswords.
    # - It will add a method named 'authenticate' to verify a user's password. If called with the correct password, it will return the user. Otherwise, it will return 'false'
    # - The attribute accessor 'password_confirmation' is optional. If it is present, a validation will be added to verify that is identical to 'password'

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i #email validation regex

    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX, unless: :from_oauth?

    geocoded_by :address
    after_validation :geocode
    
    def full_name
        "#{first_name} #{last_name}".strip
    end

    serialize :oauth_raw_data # store a hash into an attribute; deafult in yml format
    # class methods
    def self.create_from_oauth(oauth_data)
        names = oauth_data["info"]["name"]&.split || oauth_data["info"]["nickname"]
        self.create(
            first_name: names[0],
            last_name: names[1] || "",
            uid: oauth_data["uid"],
            provider: oauth_data["provider"],
            oauth_raw_data: oauth_data,
            password: SecureRandom.hex(32) # a way to generate a password, skipping password validation
        )
    end

    def self.find_by_oauth(oauth_data)
        self.find_by(
            uid: oauth_data["uid"], # find by uid to make sure the id is coming from github, especially when you have multiple oauth solutions
            provider: oauth_data["provider"]
        )
    end

    private

    def from_oauth?
        uid.present? && provider.present?
    end
end
