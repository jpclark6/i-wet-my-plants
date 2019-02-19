class Api::V1::PlantsController < ApplicationController
  def index
    garden = Garden.find_by(secret_key: params[:key])

    binding.pry




    render json: InvoiceItemSerializer.new(Invoice.find(params[:id]).invoice_items)
  end
end