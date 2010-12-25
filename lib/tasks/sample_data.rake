require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    SU = User.create!(:name => "pettair",
                 :email => "pettair@gmail.com",
                 :password => "pettair@gmail.com",
                 :password_confirmation => "pettair@gmail.com")
    SU.toggle!(:admin)
    User.create!(:name => "pettair2",
                 :email => "pettair2@gmail.com",
                 :password => "pettair2@gmail.com",
                 :password_confirmation => "pettair2@gmail.com")
    98.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
