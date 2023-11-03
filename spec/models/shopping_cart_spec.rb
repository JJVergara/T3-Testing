require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @shopping_cart = ShoppingCart.new(user: @user, products: { @product.id => 1 })
  end

  it 'is valid with valid attributes' do
    expect(@shopping_cart).to be_valid
  end

  it 'is not valid without a user' do
    @shopping_cart.user = nil
    expect(@shopping_cart).to_not be_valid
  end

  it 'calculates the total price correctly' do
    expect(@shopping_cart.precio_total).to eq(4000)
  end

  it 'calculates the shipping cost correctly' do
    expect(@shopping_cart.costo_envio).to eq(1200)
  end

  # it 'calculates the total price correctly with multiple products' do
  #   @shopping_cart.products[@product.id] = 2
  #   expect(@shopping_cart.precio_total).to eq(8000)
  # end

  # it 'calculates the shipping cost correctly with multiple products' do
  #   @shopping_cart.products[@product.id] = 2
  #   expect(@shopping_cart.costo_envio).to eq(1400)
  # end
  
  # it 'does not add a product that does not exist' do
  #   expect { @shopping_cart.products[999] = 1 }.to raise_error(ActiveRecord::RecordNotFound)
  # end
  
  # it 'does not add a negative quantity of a product' do
  #   expect { @shopping_cart.products[@product.id] = -1 }.to raise_error(ArgumentError)
  # end
end