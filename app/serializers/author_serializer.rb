class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :biography, :image_url

  def image_url
    object.image_url
  end
end
