require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @ability = Ability.new(@user)
  end

  context 'when user is admin' do
    it 'can manage all' do
      expect(@ability).to be_able_to(:manage, :all)
    end
  end

  context 'when user is present' do
    it 'can perform certain actions on Product, Review, Message and Solicitud' do
      expect(@ability).to be_able_to(%i[index leer insertar crear], Product)
      expect(@ability).to be_able_to(%i[index leer insertar crear], Review)
      expect(@ability).to be_able_to(%i[leer insertar], Message)
      expect(@ability).to be_able_to([:index], Solicitud)
    end

    it 'can insert a desired product if the product is not his' do
      expect(@ability).to be_able_to([:insert_deseado], Product.new(user_id: @user.id + 1))
    end

    it 'can insert a request if the request is not his' do
      expect(@ability).to be_able_to([:insertar], Solicitud.new(user_id: @user.id + 1))
    end

    it 'can delete and update a product if the product is his' do
      expect(@ability).to be_able_to([:eliminar, :actualizar_producto, :actualizar], @product)
    end

    it 'can delete and read a request if the request is his' do
      solicitud = Solicitud.create!(user_id: @user.id, product_id: @product.id, stock: 1, status: 'pending')
      expect(@ability).to be_able_to([:eliminar, :leer], solicitud)
    end

    it 'can delete and read a request if the request is his' do
      solicitud = Solicitud.create!(user_id: @user.id, product_id: @product.id, stock: 1, status: 'pending')
      expect(@ability).to be_able_to([:eliminar, :leer], solicitud)
    end    
  end
end