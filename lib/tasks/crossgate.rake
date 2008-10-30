namespace :cg do
  desc "Create 1000 users to database."
  task :create_users => :environment do
    generator = Rails::SecretKeyGenerator.new("crossgate")
    1.upto(1000) do
      user = User.new
      user.email = "#{generator.generate_secret[0..7]}@gmail.com"
      user.password = "123456"
      user.password_confirmation = "123456"
      user.screen_name = generator.generate_secret[0..5]
      if generator.generate_secret[0] % 2 == 0
        user.gender = User::GenderMale
      else
        user.gender = User::GenderFemale
      end
      user.save
    end
  end
end
