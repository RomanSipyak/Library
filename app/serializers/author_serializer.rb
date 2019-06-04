class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :biography, :image_url

  def image_url
    object.image_url
  end
end
