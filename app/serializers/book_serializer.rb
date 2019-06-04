class BookSerializer < ActiveModel::Serializer
  attributes :id, :units_count, :title, :year, :category, :author, :rating, :description, :image_url

  def author
    author = object.author.name
  end

  def category
    author = object.category.title
  end

  def image_url
    object.image_url
  end
end
