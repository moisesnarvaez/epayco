module EPayCo
  class Client
    # Defines methods related to Subscription
    module Subscription
      # Returns all the Subscriptions registered
      #
      # @format :json
      # @return [Array]
      # @example All the Subscription
      #   [
      #     {
      #       "_id": "wAzyX9Sutm3BaLxM2",
      #       "idPlan": "cursocarpinteria2",
      #       "data": {
      #         "_id": "LS5L9cRaJSWA4ykeM",
      #         "idClient": "cursocarpinteria2",
      #         "name": "Curso de carpintería2",
      #         "description": "En este curso aprenderás carpintería2",
      #         "amount": 30000,
      #         "currency": "cop",
      #         "interval": "month",
      #         "clientId": "5c4773856f296c674685209bbfd11f92",
      #         "status": "active",
      #         "trialDays": 30,
      #         "createdAt": "2016-09-27T15:29:38.772Z"
      #       },
      #       "periodStart": "2016-09-27T15:59:46.339Z",
      #       "periodEnd": "2016-11-26T15:59:46.339Z",
      #       "status": "active",
      #       "idUser": "5c4773856f296c674685209bbfd11f92",
      #       "idCustomer": "6eba2u73ZBh49Po7q",
      #       "createdAt": "2016-09-27T15:59:46.352Z"
      #     },
      #     {
      #       "_id": "cZHvGKHxJDd8oY72m",
      #       "idPlan": "cursocarpinteria2",
      #       "data": {
      #         "_id": "LS5L9cRaJSWA4ykeM",
      #         "idClient": "cursocarpinteria2",
      #         "name": "Curso de carpintería2",
      #         "description": "En este curso aprenderás carpintería2",
      #         "amount": 30000,
      #         "currency": "cop",
      #         "interval": "month",
      #         "clientId": "5c4773856f296c674685209bbfd11f92",
      #         "status": "active",
      #         "trialDays": 30,
      #         "createdAt": "2016-09-27T15:29:38.772Z"
      #       },
      #       "periodStart": "2016-09-27T16:49:59.758Z",
      #       "periodEnd": "2016-11-26T16:49:59.758Z",
      #       "status": "active",
      #       "idUser": "5c4773856f296c674685209bbfd11f92",
      #       "idCustomer": "cus_97dn6u3OFeeeOye",
      #       "createdAt": "2016-09-27T16:49:59.767Z"
      #     }
      #   ]
      def subscription_all(params={})
        path = "/recurring/v1/subscriptions/#{public_key}"
        response_options = { return_object: "plans" }
        get(path, params, response_options)
      end

      # Creates a new subscription
      #
      # @format :json
      # @param options The Necessary fields to create a Subscription
      # @option options [String] :id_plan Id único del plan que se desea asociar al cliente
      # @option options [String] :token_card Id de la tarjeta tokenizada con la que se efectuara un pago y ha sido asociada a un cliente
      # @option options [String] :customer Customer ID (Optional)
      # @return [Hashie::Mash]
      # @example Success
      #   {
      #       "success": true,
      #       "object": "subscription",
      #       "id": "wAzyX9Sutm3BaLxM2",
      #       "created": "Sep 27, 2016 10:59 AM",
      #       "current_period_start": "Sep 27, 2016 10:59 AM",
      #       "current_period_end": "Nov 26, 2016 10:59 AM",
      #       "customer": "6eba2u73ZBh49Po7q",
      #       "message": "Suscripción creada",
      #       "data": {
      #           "id_plan": "cursocarpinteria2",
      #           "name": "Curso de carpintería2",
      #           "description": "En este curso aprenderás carpintería2",
      #           "amount": 30000,
      #           "currency": "cop",
      #           "interval": "month",
      #           "status": "active",
      #           "trialDays": 30,
      #           "createdAt": "Sep 27, 2016 10:59 AM"
      #       },
      #       "status": "active"
      #   }
      def subscription_create(options={})
        path = "/recurring/v1/subscription/create"
        post(path, options.merge(public_key: public_key))
      end

      # Returns the details of a subscription
      #
      # @format :json
      # @return [Hashie::Mash]
      # @param subscription_id [String] Id único del suscripción que se asocio a un cliente
      # @example Subscription Details
      #   {
      #       "success": true,
      #       "id": "wAzyX9Sutm3BaLxM2",
      #       "object": "subscription",
      #       "created": "2016-09-27T15:59:46.352Z",
      #       "current_period_start": "Sep 27, 2016 10:59 AM",
      #       "current_period_end": "Nov 26, 2016 10:59 AM",
      #       "customer": "6eba2u73ZBh49Po7q",
      #       "plan": {
      #           "id_plan": "cursocarpinteria2",
      #           "name": "Curso de carpintería2",
      #           "description": "En este curso aprenderás carpintería2",
      #           "amount": 30000,
      #           "currency": "cop",
      #           "interval": "month",
      #           "status": "active",
      #           "trialDays": 30,
      #           "createdAt": "Sep 27, 2016 10:59 AM"
      #       },
      #       "status": "active"
      #   }
      def subscription_details(subscription_id, params={})
        path = "/recurring/v1/subscription/#{subscription_id}/#{public_key}"
        get(path, params)
      end

      # Cancel a subscription
      #
      # @format :json
      # @param subscription_id [String] Id único del suscripción que se asocio a un cliente
      # @return [Hashie::Mash]
      # @example Success
      #   {
      #     "status": "Actualizado",
      #     "description": "La suscripción ha sido inhabilidata para el usuario wAzyX9Sutm3BaLxM2"
      #   }
      def subscription_cancel(subscription_id)
        path = "/recurring/v1/subscription/cancel"
        request_options = { public_key: public_key, id: subscription_id }
        response_options = { return_object: 'data' }
        post(path, request_options, response_options)
      end
    end
  end
end
