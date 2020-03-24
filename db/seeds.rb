# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# ALL_DESTROY
# BASE MODELS PART
Commitment.destroy_all
User.destroy_all
Theme.destroy_all
# JOIN MODELS PART
UserCommitment.destroy_all
UserTheme.destroy_all
CommitmentTheme.destroy_all
# FORUM PART
Reply.destroy_all
Post.destroy_all
Forum.destroy_all


####################
# BASE MODELS PART :
# USER SEED
count = 0
20.times do 
	count += 1
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	User.create(id: count, email: "#{(first_name + '.' + last_name).downcase}@yopmail.com", password: "nonono", first_name: first_name, last_name: last_name, department: (rand(1..95)).to_s, name_display: [true, false].sample)
end
# ADMIN USER SEED
User.create(id: 21, role: 'admin', email: "adminlobby@yopmail.com", password: "nonono", first_name: 'Amine', last_name: 'Admin', department: (rand(1..95)).to_s, name_display: [true, false].sample)

# THEME SEED
t1 = Theme.create(title: "Alimentation", description: "Ce Thème traite des problématiques d'Alimentation, via l'impact de l'industrie agroalimentaire sur l'environnement et sur notre santé.")
t2 = Theme.create(title: "Mobilité", description: "Ce Thème traite des problématiques de Mobilité, via l'impact des modes de transport sur l'environnement et sur notre santé.")
t3 = Theme.create(title: "Mode de vie", description: "Ce Thème traite des problématiques liées au Mode de Vie, via l'impact de la société de consommation sur l'environnement et nos vies quotidiennes.")
t4 = Theme.create(title: "Animaux", description: "Ce Thème traite des problématiques de la condition animale, et du traitement des animaux dans l'industrie.") 
t5 = Theme.create(title: "Habitat", description: "Ce Thème traite des problématiques liées à l'Habitat, et sur l'impact de la strucutre de nos logements sur l'environnement et notre santé.")
t6 = Theme.create(title: "Proximité", description: "Ce Thème traite des problématiques liées à la Proximité, et des possibilités de rapprocher les acteurs de l'économie géographiquement.")
t7 = Theme.create(title: "Hygiène", description: "Ce Thème traite des problématiques liées à nos comportements liés à l'Hygiène, et des possibilités d'améliorer leurs impacts sur l'environnement.")

# COMMITMENT SEED
c2 = Commitment.new(title: "Je ne mange plus ni viande ni poisson", description: "Economie moyenne de 1,12 tCO2/an/pers")
c2.themes = t1, t2 
c2.save
c3 = Commitment.new(title: "Je fais tous mes trajets urbains courts a velo", description: "Economie moyenne de 0.32 tCO2/an/pers")
c3.themes = t2, t3
c3.save
c4 = Commitment.new(title: "Je fais du covoiturage pour tous mes trajets moyens-longs", description: "Economie moyenne de 0.27 tCO2/an/pers")
c4.themes = t2, t1
c4.save
c5 = Commitment.new(title: "Je ne prends plus l'avion", description: "Economie moyenne de 0.22 tCO2/an/pers")
c5.themes = t2, t1
c5.save
c6 = Commitment.new(title: "Je n'achete plus de vetements neufs", description: "Economie moyenne de 0.17 tCO2/an/pers")
c6.themes = t3, t1
c6.save
c7 = Commitment.new(title: "Je ne mange que local", description: "Economie moyenne de 0.17 tCO2/an/pers")
c7.themes = t6, t1
c7.save
c8 = Commitment.new(title: "Je n'achete plus d'electromenager neuf", description: "Economie moyenne de 0.16 tCO2/an/pers")
c8.themes = t2, t1
c8.save
c9 = Commitment.new(title: "Je n'achete plus de hi-tech neuf", description: "Economie moyenne de 0.16 tCO2/an/pers")
c9.themes = t3, t1
c9.save
c10 = Commitment.new(title: "Je ne fais plus de dechet et suis equipe d'une gourde", description: "Economie moyenne de 0.09 tCO2/an/pers")
c10.themes = t2, t5
c10.save
c11 = Commitment.new(title: "J'installe des eclairages LEDs dans mon logement", description: "Economie moyenne de 0.02 tCO2/an/pers")
c11.themes = t5, t1
c11.save


###########################
# JOIN TABLES MODELS PART :
# USER_COMMITMENT SEED
count = 0
20.times do
	count += 1
	uc = UserCommitment.create(id: count, user: User.all[rand(0..20)], commitment: Commitment.all[rand(0..9)])
	puts uc.errors.messages
end
# CREATING ARRAY WITHOUT DOUBLE ENTRY TO SKIP COMMITMENT MODEL VALIDATION 
uc_array = Array.new
UserCommitment.all.each do |each_uc|
	if each_uc != nil
		uc_array << each_uc
	end
end
# USER_THEME SEED
count = 0 
20.times do 
	count += 1
	ut = UserTheme.create(id: count, user: User.all[rand(0..20)], theme: Theme.all[rand(0..6)])
	puts ut.errors.messages
end
# CREATING ARRAY WITHOUT DOUBLE ENTRY TO SKIP THEME MODEL VALIDATION
ut_array = Array.new
UserTheme.all.each do |each_ut|
	if each_ut != nil
		ut_array << each_ut
	end
end


#####################
# FORUM MODELS PART :
# GENERAL FORUM SEED
Forum.create(id: 1)

# POST SEED
count = 0
20.times do
	count += 1
	@user = uc_array[rand(0..uc_array.count - 1)].user
	Post.create(id: count, forum: Forum.find(@user.commitments[0].id), user: @user, title: Faker::Book.title, content: Faker::Quote.yoda)
end

# REPLY SEED
count = 0
20.times do
	count += 1
	@user = uc_array[rand(0..uc_array.count - 1)].user
	Reply.create(id: count, user: @user, content: Faker::Quote.famous_last_words, post: Post.where(user: @user)[0])
end

puts 'SEEDS LOADED'
