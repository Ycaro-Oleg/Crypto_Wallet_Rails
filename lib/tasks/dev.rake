namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD... ") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
       %x(rails dev:add_coins) 
       %x(rails dev:add_mining_types) 
    else
      puts "Voce nao esta em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas ...") do
      coins = [
        { description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/800px-Bitcoin.svg.png" },

        {
          description: "Etherium",
          acronym: "ETH",
          url_image: "https://ethereum.org/static/5022dfe8d23b106be4d3d2b021accd46/8cb4c/eth-diamond-black-gray.png",
        },

        {
          description: "Dash",
          acronym: "DSH",
          url_image: "https://logowik.com/content/uploads/images/dash9065.jpg",
        },
      ]
      
        coins.each do |coin|
          Coin.find_or_create_by!(coin)
        end 
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração ...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end


  private

  def show_spinner(msg_start, msg_end = "Concluido!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
