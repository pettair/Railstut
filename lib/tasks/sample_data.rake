require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  su = User.create!(:name => "pettair",
               :email => "pettair@gmail.com",
               :password => "pettair@gmail.com",
               :password_confirmation => "pettair@gmail.com")
  su.toggle!(:admin)
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

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      content = Faker::Lorem.sentence(5)
      user.microposts.create!(:content => content)
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

