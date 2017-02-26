module EPayCo
  class Client
    # Defines methods related to Charges
    module Charge

      # Creates a new charge
      #
      # @format :json
      # @param options The Charge Attributes
      # @option options [String] :token_card  Token de la tarjeta tokenizada
      # @option options [String] :customer_id Id del usuario al que se asocio la tarjeta
      # @option options [String] :plan_id  Id del plan si se quiere agregar agregar una suscripción
      # @option options [String] :doc_type  Tipo de documento del cliente
      # @option options [String] :doc_number  Número de cocumento del cliente
      # @option options [String] :name  Nombre del cliente que realiza el pago
      # @option options [String] :last_name Apellidos del usuario que realiza el pago
      # @option options [String] :email Email del usuario que realiza el pago
      # @option options [String] :ip  Ip del cliente al momento de la transacción
      # @option options [String] :bill  Número de factura de la compra
      # @option options [String] :description Descripción de la compra que hace el usuario
      # @option options [String] :value Valor total a pagar del producto o servicio
      # @option options [String] :tax  Impuesto que se cobra sobre el valor total
      # @option options [String] :tax_base Base del valor total con el impuesto discriminado
      # @option options [String] :currency  Moneda en la que se ejecuta la transacción
      # @option options [String] :dues  Cantidad de cuotas que se difiere el pago
      # @return [Hashie::Mash]
      # @example Success
      #   
      def charge_create(options={})
        path = "/recurring/v1/charge/create"
        response_options = { return_object: 'data' }
        post(path, options.merge(public_key: public_key), response_options)
      end
    end
  end
end
