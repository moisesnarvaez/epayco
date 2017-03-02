module EPayCo
  class Client
    # Defines methods related to Customers
    module Customer
      # Returns all the Customers registered
      #
      # @format :json
      # @return [Array]
      # @example All the Customers
      #   [
      #     {
      #       "id_customer": "PKEMb9wfxQjttGeP",
      #       "object": "customer",
      #       "name": "Juan Fernando",
      #       "email": "cliente1@epayco.com",
      #       "phone": "3333333",
      #       "created": "21-10-2016"
      #     },
      #     {
      #       "id_customer": "qRTGGssNKXZo2Q6pL",
      #       "object": "customer",
      #       "name": "Pedro Jaramillo",
      #       "email": "cliente2@epayco.com",
      #       "phone": "3333333",
      #       "created": "21-10-2016"
      #     }
      #   ]
      def customer_all(params={})
        path = "/payment/v1/customers/#{public_key}"
        response_options = { return_object: true }
        get(path, params, response_options)
      end

      # Creates a new customer
      #
      # @format :json
      # @param options The Customer Attributes
      # @option options [String] :token_card Token de la tarjeta tokenizada
      # @option options [String] :name Nombre del cliente al que se asocia la tarjeta
      # @option options [String] :email Email del cliente al que se asocia la tarjeta
      # @option options [String] :phone Phone del cliente al que se asocia la tarjeta
      # @option options [Boolean] :default Define la terjeta con la cobra por default
      # @return [Hashie::Mash]
      # @example Success
      #   {
      #     "status": "Creado",
      #     "description": "El cliente ha sido creado con exito para realizar operaciones y enlazarlo use el id: 6eba2u73ZBh49Po7q",
      #     "customerId": "6eba2u73ZBh49Po7q",
      #     "token": "ZdTo2WFZEH9r3HC7N"
      #   }
      def customer_create(options={})
        path = "/payment/v1/customer/create"
        response_options = { return_object: 'data' }
        post(path, options.merge(public_key: public_key), response_options)
      end
    end
  end
end
