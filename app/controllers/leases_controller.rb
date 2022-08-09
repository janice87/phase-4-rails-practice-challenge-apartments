class LeasesController < ApplicationController
    def index
        render json: Lease.all
    end

    def create        
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_message}, status: :unprocessable_entity
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Lease not found"}, status: :not_found

    end

    private 

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
