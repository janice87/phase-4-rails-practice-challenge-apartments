class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :response_not_found
rescue_from ActiveRecord::RecordInvalid, with: :response_invalid

    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = find_tenant
        render json: tenant, status: :found
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find(params[:id])
    end

    def response_not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def response_invalid(invalid)
        render json: {errors: invalid.record.errors.full_message}, status: :unprocessable_entity
    end

end
