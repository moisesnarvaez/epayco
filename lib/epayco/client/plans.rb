module EPayCo
  class Client
    # Defines methods related to Plans
    module Plans
      # Returns all the Plans registered
      #
      # @format :json
      # @return [Array]
      # @example All the Plans
      #   [
      #     {
      #       "id_plan": "cursocarpinteria",
      #       "object": "plan",
      #       "name": "Curso de carpintería",
      #       "description": "En este curso aprenderás carpintería",
      #       "amount": 30000,
      #       "currency": "cop",
      #       "interval": "month",
      #       "status": "active",
      #       "trialDays": 30,
      #       "created": "Sep 26, 2016 3:15 PM"
      #     },
      #     {
      #       "id_plan": "cursocarpinteria2",
      #       "object": "plan",
      #       "name": "Curso de carpintería2",
      #       "description": "En este curso aprenderás carpintería2",
      #       "amount": 30000,
      #       "currency": "cop",
      #       "interval": "month",
      #       "status": "active",
      #       "trialDays": 30,
      #       "created": "Sep 26, 2016 3:52 PM"
      #     }
      #   ]
      def plan_all(params={})
        path = "/recurring/v1/plans/#{public_key}"
        response_options = { return_object: true }
        get(path, params, response_options)
      end

      # Returns all the Plans registered
      #
      # @format :json
      # @param options The Plan Attributes
      # @option options [String] :id_plan Proporciona un nombre único para identificar el plan
      # @option options [String] :name Nombre del plan que mostraras a tus clientes
      # @option options [String] :description Descripción del plan creado que será mostrada a tus clientes
      # @option options [Integer] :amount Hace referencia al valor que se cobrará en cada periodo
      # @option options [String] :currency Consta de 3 letras que identifica la moneda en la que harás el cobro segun las normas [ISO code](http://www.xe.com/iso4217.php) currency
      # @option options [String] :interval Especifica la recurrencia del cobro. 'day', 'week', 'month', o 'year'
      # @option options [Integer] :interval_count Especifica la cantidad de intervalos por ejemplo si interval = “month” y interval_count es igual a 2 se cobrará cada 2 meses
      # @option options [Integer] :trial_days Numero de dias que se podrán probar tus servicios antes del cobro, su valor inicial es 0
      # @return [Hashie::Mash]
      # @example Sucess
      #   {
      #     "status": true,
      #     "message": "El plan ha sido creado exitosamente",
      #     "data": {
      #       "status": "Creado",
      #       "user": "cdc4654c502f9d320ebet4f6230m669d",
      #       "id": "test"
      #     }
      #   }
      # @example Fail
      #   {
      #     "status": false,
      #     "message": "El id del plan ya existe",
      #     "data": {
      #       "status": "error",
      #       "description": "El id del mensaje es existente o ya no esta en uso id: test"
      #     }
      #   }
      def plan_create(options={})
        path = "/recurring/v1/plan/create"
        post(path, options.merge(public_key: public_key))
      end

      # Returns the details of a plan
      #
      # @format :json
      # @param plan_id [String] Plan ID (nombre único para identificar el plan)
      # @return [Hash]
      # @example Plan Details
      #   {
      #     "id_plan": "test",
      #     "object": "plan",
      #     "name": "Test",
      #     "description": "Plan de prueba",
      #     "amount": 30,
      #     "currency": "usd",
      #     "interval": "year",
      #     "status": "active",
      #     "trialDays": 0,
      #     "created": "19-02-2017"
      #   }
      def plan_details(plan_id, params={})
        path = "/recurring/v1/plan/#{public_key}/#{plan_id}"
        response_options = { return_object: true }
        get(path, params, response_options)
      end
    end
  end
end
