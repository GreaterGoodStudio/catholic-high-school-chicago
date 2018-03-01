Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :schools, only: [:index, :show] do
      resources :calendar_events, path: :calendar, only: [:index, :show]
    end

    # Search results
    post "/search", to: "search#index"
    get "/search/:token", to: "search#index", constraints: { token: /.*/ }, as: :bookmark

    # Static pages
    get "/pages/:id", to: "high_voltage/pages#show", as: :page, format: false

    root to: "search#index"
  end

  root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root
end
