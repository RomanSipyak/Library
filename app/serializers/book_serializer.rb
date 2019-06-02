class BookSerializer < ActiveModel::Serializer
  attributes :id, :units_count, :title, :year, :category, :author, :rating, :description, :image_data

  def author
    author = object.author.name
  end

  def category
    author = object.category.title
  end

  def image_data
    image_data = object.image_url
  end
end
