class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    merchant = Merchant.create(company_name: sign_up_params[:company_name])
    build_resource(sign_up_params.merge(merchant: merchant))

    resource.save
    yield resource if block_given?

    if resource.persisted?
      sign_in(resource)
      resource.update(admin: true, merchant_id: merchant.id)
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters for user registration
  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :company_name)
  end
end
