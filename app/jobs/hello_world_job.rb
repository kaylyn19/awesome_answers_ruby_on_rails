class HelloWorldJob < ApplicationJob
  #  rails g job hello_world
  # To start a worker:
  queue_as :default

  # when a job is executed, the perform method will be called
  def perform(*args)
    # Do something later
    puts "___________________________________"
    puts "Runnign a super awesome job"
    puts "___________________________________"
  end

  # rails jobs:work

  # To run a job, use any of the following methods

  # <JobClass>.perform_now(<args>)
  # This will run the job synchronously (or in the foreground) meaning that it iwll not be in the queue.
  # if it is called from Rails, Rails would execute the job instaed of a worker.
end
