# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth', registrations: 'registrations' }

  root 'home#index'

  ## draw routes
  draw :profile
  draw :products
  draw :categories
  draw :admin
end

# == Route Map
#
#                                   Prefix Verb     URI Pattern                                                                                       Controller#Action
#                         new_user_session GET      /users/sign_in(.:format)                                                                          devise/sessions#new
#                             user_session POST     /users/sign_in(.:format)                                                                          devise/sessions#create
#                     destroy_user_session DELETE   /users/sign_out(.:format)                                                                         devise/sessions#destroy
#         user_facebook_omniauth_authorize GET|POST /users/auth/facebook(.:format)                                                                    omniauth#passthru
#          user_facebook_omniauth_callback GET|POST /users/auth/facebook/callback(.:format)                                                           omniauth#facebook
#    user_google_oauth2_omniauth_authorize GET|POST /users/auth/google_oauth2(.:format)                                                               omniauth#passthru
#     user_google_oauth2_omniauth_callback GET|POST /users/auth/google_oauth2/callback(.:format)                                                      omniauth#google_oauth2
#                        new_user_password GET      /users/password/new(.:format)                                                                     devise/passwords#new
#                       edit_user_password GET      /users/password/edit(.:format)                                                                    devise/passwords#edit
#                            user_password PATCH    /users/password(.:format)                                                                         devise/passwords#update
#                                          PUT      /users/password(.:format)                                                                         devise/passwords#update
#                                          POST     /users/password(.:format)                                                                         devise/passwords#create
#                 cancel_user_registration GET      /users/cancel(.:format)                                                                           registrations#cancel
#                    new_user_registration GET      /users/sign_up(.:format)                                                                          registrations#new
#                   edit_user_registration GET      /users/edit(.:format)                                                                             registrations#edit
#                        user_registration PATCH    /users(.:format)                                                                                  registrations#update
#                                          PUT      /users(.:format)                                                                                  registrations#update
#                                          DELETE   /users(.:format)                                                                                  registrations#destroy
#                                          POST     /users(.:format)                                                                                  registrations#create
#                                     root GET      /                                                                                                 home#index
#                            profile_index GET      /profile(.:format)                                                                                profile#index
#                                 products GET      /products(.:format)                                                                               products#index
#                                  product GET      /products/:slug(.:format)                                                                         products#show
#                               categories GET      /categories(.:format)                                                                             categories#index
#                                          POST     /categories(.:format)                                                                             categories#create
#                             new_category GET      /categories/new(.:format)                                                                         categories#new
#                            edit_category GET      /categories/:id/edit(.:format)                                                                    categories#edit
#                                 category GET      /categories/:id(.:format)                                                                         categories#show
#                                          PATCH    /categories/:id(.:format)                                                                         categories#update
#                                          PUT      /categories/:id(.:format)                                                                         categories#update
#                                          DELETE   /categories/:id(.:format)                                                                         categories#destroy
#                               admin_root GET      /admin(.:format)                                                                                  admin/home#index
#                           admin_products GET      /admin/products(.:format)                                                                         admin/products#index
#                                          POST     /admin/products(.:format)                                                                         admin/products#create
#                        new_admin_product GET      /admin/products/new(.:format)                                                                     admin/products#new
#                       edit_admin_product GET      /admin/products/:id/edit(.:format)                                                                admin/products#edit
#                            admin_product GET      /admin/products/:id(.:format)                                                                     admin/products#show
#                                          PATCH    /admin/products/:id(.:format)                                                                     admin/products#update
#                                          PUT      /admin/products/:id(.:format)                                                                     admin/products#update
#                                          DELETE   /admin/products/:id(.:format)                                                                     admin/products#destroy
#                         admin_categories GET      /admin/categories(.:format)                                                                       admin/categories#index
#                                          POST     /admin/categories(.:format)                                                                       admin/categories#create
#                       new_admin_category GET      /admin/categories/new(.:format)                                                                   admin/categories#new
#                      edit_admin_category GET      /admin/categories/:id/edit(.:format)                                                              admin/categories#edit
#                           admin_category GET      /admin/categories/:id(.:format)                                                                   admin/categories#show
#                                          PATCH    /admin/categories/:id(.:format)                                                                   admin/categories#update
#                                          PUT      /admin/categories/:id(.:format)                                                                   admin/categories#update
#                                          DELETE   /admin/categories/:id(.:format)                                                                   admin/categories#destroy
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
