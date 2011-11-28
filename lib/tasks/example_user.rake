namespace :db do
  desc "Set up a sample user"
  task :example => :environment do
    make_example
  end
end

def make_example
  user = User.find(1)
  user.toggle!(:admin)
end
