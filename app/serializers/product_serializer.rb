class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category, :price, :discount_percentage,
             :rating, :stock, :tags, :brand, :sku, :weight, :dimensions, :warranty_information,
             :shipping_information, :availability_status, :reviews, :return_policy,
             :min_order_quantity, :meta, :images, :thumbnail


  def category
    object.category.name
  end

  def price
    object.sku.price
  end

  def discount_percentage
    object.sku.discount_percentage
  end

  def tags
    object.tags.map(&:name)
  end

  def brand
    object.brand.name
  end

  def sku
    object.sku.name
  end

  def weight
    object.sku.weight
  end

  def dimensions
    { width: object.sku.width, height: object.sku.height, depth: object.sku.depth }
  end

  def meta
    { created_at: object.created_at, updated_at: object.updated_at, barcode: object.barcode, qrcode: object.qrcode }
  end

  def reviews
    object.reviews.map{ |review| {rating: review.rating, comment: review.comment, date: review.created_at, name: review.name, email: review.email } }
  end

  def images
    [object.image.url]
  end

  def thumbnail
    object.image.thumbnail_url
  end

end
