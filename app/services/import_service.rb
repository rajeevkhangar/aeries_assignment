class ImportService

  class << self

    def import!
      puts 'Starting product import task'
      products = api_response['products']
      import_products_data products
      puts 'Completed product import task'
    end

    private

    def server_uri
      'https://dummyjson.com/products'
    end

    def api_call(uri = server_uri)
      RestClient.get uri, { accept: :json }
    end

    def api_response
      begin
        JSON.parse api_call.body
      rescue Exception => e
        raise e.message
      end
    end

    def import_products_data(products)
      ActiveRecord::Base.transaction do
        products.each do | hash |

          category = Category.where(name: hash['category']).first_or_create
          brand = Brand.where(name: hash['brand']).first_or_create

          product = Product.where(id: hash['id']).first_or_initialize
          product.id = hash['id']
          product.title = hash['title'].reverse
          product.description = hash['description']
          product.category = category
          product.rating = hash['rating']
          product.stock = hash['stock']
          hash['tags'].each { | tag | product.tags.build(name: tag) }

          product.brand = brand

          product.build_sku(name: hash['sku'], weight: hash['weight'], width: hash['dimensions']['width'],
                            height: hash['dimensions']['height'], depth: hash['dimensions']['depth'],
                            discount_percentage: hash['discountPercentage'],
                            price: hash['price']
                        )

          product.warranty_information = hash['warrantyInformation']
          product.shipping_information = hash['shippingInformation']
          product.availability_status = hash['availabilityStatus']
          product.return_policy = hash['returnPolicy']
          product.min_order_quantity = hash['minimumOrderQuantity']
          product.barcode = hash['meta']['barcode']
          product.qrcode = hash['meta']['qrCode']
          product.created_at = hash['meta']['createdAt']
          product.updated_at = hash['meta']['updatedAt']

          product.build_image(url: hash['images'][0], thumbnail_url: hash['thumbnail'])

          hash['reviews'].each do | review |

            product.reviews.build(rating: review['rating'], comment: review['comment'], 
                                  name: review['reviewerName'], email: review['reviewerEmail'],
                                  created_at: review['date']
                              )
          end 
          
          product.save!

        end
      end
    end
  end
end