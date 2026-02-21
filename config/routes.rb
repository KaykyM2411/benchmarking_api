Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "benchmarks/as_json", to: "benchmarks#as_json_strategy"
  get "benchmarks/dto", to: "benchmarks#dto"
  get "benchmarks/panko", to: "benchmarks#panko"
  get "benchmarks/oj", to: "benchmarks#oj"
end
