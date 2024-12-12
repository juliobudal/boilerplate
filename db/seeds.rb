# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Landing.destroy_all

Landing.create(name: "Page", content: {
  "content": [
    {
      "type": "heading",
      "id": "1234567890",
      "content": "Título da página"
    },
    {
      "type": "paragraph",
      "id": "1234567891",
      "content": "Conteúdo do parágrafo"
    }
  ]
})
