# frozen_string_literal: true

Rails.application.routes.draw do
  resources :options
  resources :option_types
  devise_for :users, path: '/auth', controllers: { omniauth_callbacks: 'omniauth', registrations: 'registrations' }

  root 'home#index'

  ## draw routes
  draw :profile
  draw :products
  draw :admin

  ## error routes
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end

# == Route Map
#
#                                   Prefix Verb     URI Pattern                                                                                       Controller#Action
#                                  options GET      /options(.:format)                                                                                options#index
#                                          POST     /options(.:format)                                                                                options#create
#                               new_option GET      /options/new(.:format)                                                                            options#new
#                              edit_option GET      /options/:id/edit(.:format)                                                                       options#edit
#                                   option GET      /options/:id(.:format)                                                                            options#show
#                                          PATCH    /options/:id(.:format)                                                                            options#update
#                                          PUT      /options/:id(.:format)                                                                            options#update
#                                          DELETE   /options/:id(.:format)                                                                            options#destroy
#                             option_types GET      /option_types(.:format)                                                                           option_types#index
#                                          POST     /option_types(.:format)                                                                           option_types#create
#                          new_option_type GET      /option_types/new(.:format)                                                                       option_types#new
#                         edit_option_type GET      /option_types/:id/edit(.:format)                                                                  option_types#edit
#                              option_type GET      /option_types/:id(.:format)                                                                       option_types#show
#                                          PATCH    /option_types/:id(.:format)                                                                       option_types#update
#                                          PUT      /option_types/:id(.:format)                                                                       option_types#update
#                                          DELETE   /option_types/:id(.:format)                                                                       option_types#destroy
#                         new_user_session GET      /auth/sign_in(.:format)                                                                           devise/sessions#new
#                             user_session POST     /auth/sign_in(.:format)                                                                           devise/sessions#create
#                     destroy_user_session DELETE   /auth/sign_out(.:format)                                                                          devise/sessions#destroy
#         user_facebook_omniauth_authorize GET|POST /auth/auth/facebook(.:format)                                                                     omniauth#passthru
#          user_facebook_omniauth_callback GET|POST /auth/auth/facebook/callback(.:format)                                                            omniauth#facebook
#    user_google_oauth2_omniauth_authorize GET|POST /auth/auth/google_oauth2(.:format)                                                                omniauth#passthru
#     user_google_oauth2_omniauth_callback GET|POST /auth/auth/google_oauth2/callback(.:format)                                                       omniauth#google_oauth2
#                        new_user_password GET      /auth/password/new(.:format)                                                                      devise/passwords#new
#                       edit_user_password GET      /auth/password/edit(.:format)                                                                     devise/passwords#edit
#                            user_password PATCH    /auth/password(.:format)                                                                          devise/passwords#update
#                                          PUT      /auth/password(.:format)                                                                          devise/passwords#update
#                                          POST     /auth/password(.:format)                                                                          devise/passwords#create
#                 cancel_user_registration GET      /auth/cancel(.:format)                                                                            registrations#cancel
#                    new_user_registration GET      /auth/sign_up(.:format)                                                                           registrations#new
#                   edit_user_registration GET      /auth/edit(.:format)                                                                              registrations#edit
#                        user_registration PATCH    /auth(.:format)                                                                                   registrations#update
#                                          PUT      /auth(.:format)                                                                                   registrations#update
#                                          DELETE   /auth(.:format)                                                                                   registrations#destroy
#                                          POST     /auth(.:format)                                                                                   registrations#create
#                                     root GET      /                                                                                                 home#index
#                            profile_index GET      /profile(.:format)                                                                                profile#index
#                                 products GET      /products(.:format)                                                                               products#index
#                                  product GET      /products/:slug(.:format)                                                                         products#show
#                               admin_root GET      /admin(.:format)                                                                                  admin/home#index
#                   product_admin_variants GET      /admin/products/:id/variants(.:format)                                                            admin/variants#product_variants
#            product_create_admin_variants POST     /admin/products/:id/variants(.:format)                                                            admin/variants#product_variant_create
#               product_new_admin_variants GET      /admin/products/:id/variants/new(.:format)                                                        admin/variants#product_variant_new
#          product_position_admin_variants PUT      /admin/products/:id/variants/:vid/update_position(.:format)                                       admin/variants#update_position
#                     product_admin_images GET      /admin/products/:id/images(.:format)                                                              admin/images#product_images
#                    stocks_admin_products GET      /admin/products/:id/stocks(.:format)                                                              admin/products#stocks
#                         admin_categories GET      /admin/products/categories(.:format)                                                              admin/categories#index
#                                          POST     /admin/products/categories(.:format)                                                              admin/categories#create
#                       new_admin_category GET      /admin/products/categories/new(.:format)                                                          admin/categories#new
#                      edit_admin_category GET      /admin/products/categories/:id/edit(.:format)                                                     admin/categories#edit
#                           admin_category GET      /admin/products/categories/:id(.:format)                                                          admin/categories#show
#                                          PATCH    /admin/products/categories/:id(.:format)                                                          admin/categories#update
#                                          PUT      /admin/products/categories/:id(.:format)                                                          admin/categories#update
#                                          DELETE   /admin/products/categories/:id(.:format)                                                          admin/categories#destroy
#                           admin_products GET      /admin/products(.:format)                                                                         admin/products#index
#                                          POST     /admin/products(.:format)                                                                         admin/products#create
#                        new_admin_product GET      /admin/products/new(.:format)                                                                     admin/products#new
#                       edit_admin_product GET      /admin/products/:id/edit(.:format)                                                                admin/products#edit
#                            admin_product GET      /admin/products/:id(.:format)                                                                     admin/products#show
#                                          PATCH    /admin/products/:id(.:format)                                                                     admin/products#update
#                                          PUT      /admin/products/:id(.:format)                                                                     admin/products#update
#                                          DELETE   /admin/products/:id(.:format)                                                                     admin/products#destroy
#                                                   /404(.:format)                                                                                    errors#not_found
#                                                   /500(.:format)                                                                                    errors#internal_server_error
#         turbo_recede_historical_location GET      /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET      /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET      /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST     /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST     /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST     /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET      /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST     /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST     /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET      /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST     /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#       edit_rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                                 rails/conductor/action_mailbox/inbound_emails#edit
#            rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
#                                          PATCH    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
#                                          PUT      /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
#                                          DELETE   /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#destroy
# new_rails_conductor_inbound_email_source GET      /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST     /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST     /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST     /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET      /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET      /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET      /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET      /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
