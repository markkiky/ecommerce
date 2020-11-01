class ShoppingCart < ApplicationRecord
  delegate :order_subtotal, to: :order

  def initialize(token:)
    @token = token
  end

  def order
    @order ||= Order.find_or_create_by(token: @token, order_status: "cart") do |order|
      order.order_subtotal = 0
    end
  end

  def items_count
    order.items.sum(:quantity)
  end

  def add_item(product_id:, quantity:, price:)
    product = Product.find(product_id)

    order_item = order.items.find_or_initialize_by(
      product_id: product_id,
    )

    order_item.price = price
    order_item.quantity = quantity

    ActiveRecord::Base.transaction do
      order_item.save
      update_sub_total!
    end
  end

  def add_item_old(product_id:, quantity: 1)
    product = Product.find(product_id)

    order_item = order.items.find_or_initialize_by(
      product_id: product_id,
    )

    order_item.price = product.price
    order_item.quantity = quantity

    ActiveRecord::Base.transaction do
      order_item.save
      update_sub_total!
    end
  end

  def update_item(product_id:, quantity: 1)
    product = Product.find(product_id)

    order_item = order.items.find_or_initialize_by(
      product_id: product_id,
    )

    order_item.price = product.price
    order_item.quantity = quantity

    ActiveRecord::Base.transaction do
      order_item.update
      update_sub_total!
    end
  end

  def remove_item(id:)
    ActiveRecord::Base.transaction do
      order.items.destroy(id)
      update_sub_total!
    end
  end

  def update_sub_total!
    order.order_subtotal = order.items.sum("quantity * price")
    order.save
  end

  def update_item(product_id:, quantity: 1)
    product = Product.find(product_id)

    order_item = order.items.find_or_initialize_by(
      product_id: product_id,
    )

    order_item.price = product.price
    order_item.quantity = quantity

    ActiveRecord::Base.transaction do
      order_item.update
      update_sub_total!
    end
  end

  def remove_item(id:)
    ActiveRecord::Base.transaction do
      order.items.destroy(id)
      update_sub_total!
    end
  end

  def update_sub_total!
    order.order_subtotal = order.items.sum("quantity * price")
    order.save
  end
end
