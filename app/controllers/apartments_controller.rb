class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :response_not_found
rescue_from ActiveRecord::RecordInvalid, with: :response_invalid

    def index
        apartments = Apartment.all
        render json: apartments, status: :ok
    end

    def show
        apartment = find_apartment
        render json: apartment. status: :found
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update 
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = find_apartment
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])
    end

    def response_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def response_invalid(invalid)
        render json: {errors: invalid.record.errors.full_message}, status: :unprocessable_entity
    end

end
