namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    puts "Cadastrando os tipos de contatos..."

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts "Tipos de contatos cadastrados com sucesso!"

    puts "Cadastrando os contatos..."

    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind_id: Kind.all.sample.id # Atribui o ID de um tipo de contato aleatório a cada contato
      )
    end

    puts "Contatos cadastrados com sucesso!"    
  end
end
