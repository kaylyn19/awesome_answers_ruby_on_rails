FactoryBot.define do

  #rails g factory_bot:model JobPost       because JobPost model was alraedy created
  factory :job_post do
    # FactoryBot.attributes_for(:job_post)
    # returns a plain hash of the parameters required to create a JobPost

    # FactoryBot.build(:job_post)
    # returns a new unpersited instance of a JobPost (using the factory)

    # FactoryBot.create(:job_post)
    # returns a persisted instance of JobPost (using the factory)

    # All your factories must always generate valid instance of your data. ALWAYS!
    title { Faker::Job.title }
    description { Faker::Job.field }
    min_salary {rand(20_001..100_000)}
    max_salary {rand(100_001..300_000)}
    # The line below will create a user (using its factory) before creating a job post
    # This is necessary to pass the validation added by 'belongs_to :user'
    association(:user, factory: :user)
    # if the factory has the same name as the association, you can shortent this to : user
    # line 21 can be replaced by
    # user
  end
end
