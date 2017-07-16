#### This is gem is no longer maintained, please refer to this one: [https://github.com/epayco/epayco-ruby](https://github.com/epayco/epayco-ruby)

# EPayCo
A Gem to interact with [epayco.co](https://epayco.co/) API

[![Gem Version](https://badge.fury.io/rb/epayco.png)](http://badge.fury.io/rb/epayco)
[![Code Climate](https://codeclimate.com/github/moisesnarvaez/epayco.png)](https://codeclimate.com/github/moisesnarvaez/epayco)
[![Dependency Status](https://gemnasium.com/moisesnarvaez/epayco.png)](https://gemnasium.com/moisesnarvaez/epayco)
[![Build Status](https://travis-ci.org/moisesnarvaez/epayco.png)](https://travis-ci.org/moisesnarvaez/epayco)

## Installation
Add this line to your application's Gemfile:

    gem 'epayco'

And then execute:

    bundle install

## Configuration

Set the Api Keys:

Make sure to set `EPAYCO_PUBLIC_KEY` and `EPAYCO_PRIVATE_KEY` in your environement variables. You can get your API keys in your [configuration page](https://dashboard.epayco.co/clientes/configuracion).

```ruby
EPayCo.public_key = ENV['EPAYCO_PUBLIC_KEY']
EPayCo.private_key = ENV['EPAYCO_PRIVATE_KEY']
EPayCo.test_mode = true # Indicates if the payments requests will be done in Test Mode (default: false)

```

Multiple tokens or multithreaded usage:

```ruby
settings = { public_key: ENV['EPAYCO_PUBLIC_KEY'], private_key: ENV['EPAYCO_PRIVATE_KEY'] }
epayco_client = EPayCo::Client.new(settings)
epayco_client.plan_all
```

## Usage

### Plans

```ruby
# Creating a Plan
plan_params = {
  id_plan: "test",
  name: "Test",
  description: "Plan de prueba",
  amount: 30,
  currency: "USD",
  interval: "year",
  interval_count: 1,
  trial_days: 0
}
response = EPayCo.plan_create(plan_params)
=> {"status"=>"Creado", "user"=>"e54cd3e4f2a9d6be230cc50500cc69dc4672350", "id"=>"test"}

# Listing all Plans
plans = EPayCo.plan_all
=> [{"id_plan"=>"test",
  "object"=>"plan",
  "name"=>"Test",
  "description"=>"Plan de prueba",
  "amount"=>30,
  "currency"=>"usd",
  "interval"=>"year",
  "status"=>"active",
  "trialDays"=>0,
  "created"=>"19-02-2017"}]

# Udating a Plan
response = EPayCo.plan_update(plan_params)
=> {"status"=>"Actualizado", "userId"=>"5c4773856f296c674685209bbfd11f92", "planId"=>"test"}
```

### Customers

```ruby
# Creating a Customer
customer_params = {
  token_card: "ZdTo2WFZEH9r3HC7N",
  name: "Joe Doe",
  email: "joe@payco.co",
  phone: "3005234321",
  default: true
}
response = EPayCo.customer_create(customer_params)
=> {"status"=>"Creado",
 "description"=>"El cliente ha sido creado con exito para realizar operaciones y enlazarlo use el id: q2u73ZB6eba49Po7h",
 "customerId"=>"q2u73ZB6eba49Po7h",
 "token"=>"F3HZdToH9r7N2WCZE"}

# Listing all Customers
customers = EPayCo.customer_all
=> [{"id_customer"=>"PKEMb9wfxQjttGeP",
  "object"=>"customer",
  "name"=>"Juan Fernando",
  "email"=>"cliente1@epayco.com",
  "phone"=>"3333333",
  "created"=>"21-10-2016"},
 {"id_customer"=>"qRTGGssNKXZo2Q6pL",
  "object"=>"customer",
  "name"=>"Pedro Jaramillo",
  "email"=>"cliente2@epayco.com",
  "phone"=>"3333333",
  "created"=>"21-10-2016"}]
```

### Subscription
```ruby
# Creating a Subscription
subscription_params = {
  id_plan: "cursocarpinteria",
  customer: "6eba2u73ZBh49Po7q",
  token_card: "ZdTo2WFZEH9r3HC7N"
}
response = EPayCo.subscription_create(subscription_params)
=> {"success"=>true,
 "object"=>"subscription",
 "id"=>"wAzyX9Sutm3BaLxM2",
 "created"=>"Sep 27, 2016 10:59 AM",
 "current_period_start"=>"Sep 27, 2016 10:59 AM",
 "current_period_end"=>"Nov 26, 2016 10:59 AM",
 "customer"=>"6eba2u73ZBh49Po7q",
 "message"=>"Suscripción creada",
 "data"=>
  {"id_plan"=>"cursocarpinteria2",
   "name"=>"Curso de carpintería2",
   "description"=>"En este curso aprenderás carpintería2",
   "amount"=>30000,
   "currency"=>"cop",
   "interval"=>"month",
   "status"=>"active",
   "trialDays"=>30,
   "createdAt"=>"Sep 27, 2016 10:59 AM"},
 "status"=>"active"}

# Listing all Subscriptions
subscriptions = EPayCo.subscription_all
=> [{"_id"=>"wAzyX9Sutm3BaLxM2",
  "idPlan"=>"cursocarpinteria2",
  "data"=>
   {"_id"=>"LS5L9cRaJSWA4ykeM",
    "idClient"=>"cursocarpinteria2",
    "name"=>"Curso de carpintería2",
    "description"=>"En este curso aprenderás carpintería2",
    "amount"=>30000,
    "currency"=>"cop",
    "interval"=>"month",
    "clientId"=>"5c4773856f296c674685209bbfd11f92",
    "status"=>"active",
    "trialDays"=>30,
    "createdAt"=>"2016-09-27T15:29:38.772Z"},
  "periodStart"=>"2016-09-27T15:59:46.339Z",
  "periodEnd"=>"2016-11-26T15:59:46.339Z",
  "status"=>"active",
  "idUser"=>"5c4773856f296c674685209bbfd11f92",
  "idCustomer"=>"6eba2u73ZBh49Po7q",
  "createdAt"=>"2016-09-27T15:59:46.352Z"}]

# Getting a Subscription Details
subscription = EPayCo.subscription_details
=> {"success"=>true,
 "object"=>"subscription",
 "id"=>"wAzyX9Sutm3BaLxM2",
 "created"=>"Sep 27, 2016 10:59 AM",
 "current_period_start"=>"Sep 27, 2016 10:59 AM",
 "current_period_end"=>"Nov 26, 2016 10:59 AM",
 "customer"=>"6eba2u73ZBh49Po7q",
 "message"=>"Suscripción creada",
 "data"=>
  {"id_plan"=>"cursocarpinteria2",
   "name"=>"Curso de carpintería2",
   "description"=>"En este curso aprenderás carpintería2",
   "amount"=>30000,
   "currency"=>"cop",
   "interval"=>"month",
   "status"=>"active",
   "trialDays"=>30,
   "createdAt"=>"Sep 27, 2016 10:59 AM"},
 "status"=>"active"}

# Canceling a Subscription Details
subscription_id = "wAzyX9Sutm3BaLxM2"
response = EPayCo.subscription_cancel(subscription_id)
=> {"status"=>"Actualizado", "description"=>"La suscripción ha sido inhabilidata para el usuario wAzyX9Sutm3BaLxM2"}
```

### Charge

```ruby
# Creating a Charge
charge_params = {
  token_card: "hMsDAjwD7KLsgZQ54",
  customer_id: "6eba2u73ZBh49Po7q",
  plan_id: "cursocarpinteria",
  doc_type: "CC",
  doc_number: "1035851980",
  name: "John",
  last_name: "Doe",
  email: "example@email.com",
  ip: "192.198.2.114",
  bill: "OR-1234",
  description: "Test Payment",
  value: "116000",
  tax: "16000",
  tax_base: "100000",
  currency: "COP",
  dues: "12"
}
response = EPayCo.charge_create(charge_params)
=> {"status"=>"Creado", "description"=>"El charge ha sido creado con exito", "customerId"=>"6eba2u73ZBh49Po7q", "token"=>"ZdTo2WFZEH9r3HC7N"}
```

## Contributing
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by closing [issues](http://github.com/Instagram/instagram-ruby-gem/issues)
* by reviewing patches


## Submitting a Pull Request

1. Fork it
2. [Create a topic branch](http://learn.github.com/p/branching.html)
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run rake `doc:yard`. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run `bundle exec rspec`. If your changes are not 100% covered, go back to step 6.
8. Commit your changes and push
9. [Submit a pull request](http://help.github.com/send-pull-requests/). Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)

## Inspiration
* [Mercury Parser Gem](https://github.com/moisesnarvaez/mercury_parser)
* [The Instagram Ruby Gem](https://github.com/facebookarchive/instagram-ruby-gem)

## Author
[Moises Narvaez](http://www.moisesnarvaez.com)

## Copyright
Copyright (c) 2017 Moises Narvaez

## License
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
