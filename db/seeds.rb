# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create a test user if it doesn't exist
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

# Technology Area
technology = StudyArea.find_or_create_by!(title: 'Tecnologia', user: user) do |area|
  area.description = 'Estudos relacionados a tecnologia e IA'
end

['Flowise', 'Victor Demarco', 'IFTL - IA'].each do |goal_title|
  technology.goals.find_or_create_by!(title: goal_title) do |goal|
    goal.description = "Estudar sobre #{goal_title}"
    goal.status = 'not_started'
    goal.due_date = 30.days.from_now
  end
end

# Productivity Area
productivity = StudyArea.find_or_create_by!(title: 'Produtividade', user: user) do |area|
  area.description = 'Estudos sobre produtividade e gestão de tempo'
end

productivity.goals.find_or_create_by!(title: 'GTD') do |goal|
  goal.description = 'Estudar e implementar o método Getting Things Done'
  goal.status = 'in_progress'
  goal.due_date = 15.days.from_now
end

productivity.goals.find_or_create_by!(title: 'TickTick para Produtividade') do |goal|
  goal.description = 'Aprender a usar o TickTick para aumentar a produtividade'
  goal.status = 'completed'
  goal.due_date = 1.day.ago
end

# Personal Development Area
personal = StudyArea.find_or_create_by!(title: 'Desenvolvimento pessoal', user: user) do |area|
  area.description = 'Estudos para desenvolvimento pessoal'
end

['Casamento - Ítalo Marsili', 'Política - Phdelino'].each do |goal_title|
  personal.goals.find_or_create_by!(title: goal_title) do |goal|
    goal.description = "Estudar sobre #{goal_title}"
    goal.status = 'not_started'
    goal.due_date = 45.days.from_now
  end
end

# Programming Area
programming = StudyArea.find_or_create_by!(title: 'Programação', user: user) do |area|
  area.description = 'Estudos sobre programação e boas práticas'
end

['Hotwire', 'Clean Code - Rodrigo Branas'].each do |goal_title|
  programming.goals.find_or_create_by!(title: goal_title) do |goal|
    goal.description = "Estudar sobre #{goal_title}"
    goal.status = 'not_started'
    goal.due_date = 60.days.from_now
  end
end

puts "Seed completed successfully!"
puts "Login with:"
puts "Email: test@example.com"
puts "Password: password123"
