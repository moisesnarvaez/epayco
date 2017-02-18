module EPayCo
  class Client
    # Defines methods related to Plans
    module Plans
      # Returns all the Plans registered
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @return [Hashie::Mash]
      # @example All the Plans
      #   {
      #     "status": "success",
      #     "object": "plans",
      #     "plans": [
      #       {
      #         "id_plan": "cursocarpinteria",
      #         "object": "plan",
      #         "name": "Curso de carpintería",
      #         "description": "En este curso aprenderás carpintería",
      #         "amount": 30000,
      #         "currency": "cop",
      #         "interval": "month",
      #         "status": "active",
      #         "trialDays": 30,
      #         "created": "Sep 26, 2016 3:15 PM"
      #       },
      #       {
      #         "id_plan": "cursocarpinteria2",
      #         "object": "plan",
      #         "name": "Curso de carpintería2",
      #         "description": "En este curso aprenderás carpintería2",
      #         "amount": 30000,
      #         "currency": "cop",
      #         "interval": "month",
      #         "status": "active",
      #         "trialDays": 30,
      #         "created": "Sep 26, 2016 3:52 PM"
      #       }
      #     ]
      #   }
      def plan_all(options={})
        response = get("/recurring/v1/plans/#{public_key}", options, true)
        # TODO: The response is wrong :/ You can review it here!
        binding.pry
        response
      end
    end
  end
end
