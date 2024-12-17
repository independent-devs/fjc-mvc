# frozen_string_literal: true

Rails.application.routes.draw do
  ## draw routes
  draw :auth
  draw :admin
  draw :storefront

  # Api only
  # draw :api_v1

  ## error routes
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end

# == Route Map
#
#                                   Prefix Verb     URI Pattern                                                                                       Controller#Action
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
#                                    admin GET      /admin(.:format)                                                                                  redirect(301, /admin/dashboard)
#                    admin_dashboard_index GET      /admin/dashboard(.:format)                                                                        admin/dashboard#index
#                             admin_orders GET      /admin/orders(.:format)                                                                           admin/orders#index
#                              admin_order GET      /admin/orders/:id(.:format)                                                                       admin/orders#show
#           position_admin_product_variant PATCH    /admin/products/:product_id/variants/:id/position(.:format)                                       admin/products/variants#position
#                   admin_product_variants GET      /admin/products/:product_id/variants(.:format)                                                    admin/products/variants#index
#                                          POST     /admin/products/:product_id/variants(.:format)                                                    admin/products/variants#create
#                new_admin_product_variant GET      /admin/products/:product_id/variants/new(.:format)                                                admin/products/variants#new
#                    admin_product_variant GET      /admin/products/:product_id/variants/:id(.:format)                                                admin/products/variants#show
#                                          PATCH    /admin/products/:product_id/variants/:id(.:format)                                                admin/products/variants#update
#                                          PUT      /admin/products/:product_id/variants/:id(.:format)                                                admin/products/variants#update
#                                          DELETE   /admin/products/:product_id/variants/:id(.:format)                                                admin/products/variants#destroy
#               modify_admin_product_stock PUT      /admin/products/:product_id/stocks/:id/modify(.:format)                                           admin/products/stocks#modify
#                     admin_product_stocks GET      /admin/products/:product_id/stocks(.:format)                                                      admin/products/stocks#index
#                      admin_product_stock PATCH    /admin/products/:product_id/stocks/:id(.:format)                                                  admin/products/stocks#update
#                                          PUT      /admin/products/:product_id/stocks/:id(.:format)                                                  admin/products/stocks#update
#              upload_admin_product_images POST     /admin/products/:product_id/images/upload(.:format)                                               admin/products/images#upload
#             position_admin_product_image PATCH    /admin/products/:product_id/images/:id/position(.:format)                                         admin/products/images#position
#                     admin_product_images GET      /admin/products/:product_id/images(.:format)                                                      admin/products/images#index
#                                          POST     /admin/products/:product_id/images(.:format)                                                      admin/products/images#create
#                      admin_product_image GET      /admin/products/:product_id/images/:id(.:format)                                                  admin/products/images#show
#                                          PATCH    /admin/products/:product_id/images/:id(.:format)                                                  admin/products/images#update
#                                          PUT      /admin/products/:product_id/images/:id(.:format)                                                  admin/products/images#update
#                                          DELETE   /admin/products/:product_id/images/:id(.:format)                                                  admin/products/images#destroy
#                         admin_categories GET      /admin/products/categories(.:format)                                                              admin/categories#index
#                                          POST     /admin/products/categories(.:format)                                                              admin/categories#create
#                       new_admin_category GET      /admin/products/categories/new(.:format)                                                          admin/categories#new
#                      edit_admin_category GET      /admin/products/categories/:id/edit(.:format)                                                     admin/categories#edit
#                           admin_category GET      /admin/products/categories/:id(.:format)                                                          admin/categories#show
#                                          PATCH    /admin/products/categories/:id(.:format)                                                          admin/categories#update
#                                          PUT      /admin/products/categories/:id(.:format)                                                          admin/categories#update
#                                          DELETE   /admin/products/categories/:id(.:format)                                                          admin/categories#destroy
#                            admin_options GET      /admin/products/options(.:format)                                                                 admin/options#index
#                           admin_products GET      /admin/products(.:format)                                                                         admin/products#index
#                                          POST     /admin/products(.:format)                                                                         admin/products#create
#                        new_admin_product GET      /admin/products/new(.:format)                                                                     admin/products#new
#                       edit_admin_product GET      /admin/products/:id/edit(.:format)                                                                admin/products#edit
#                            admin_product GET      /admin/products/:id(.:format)                                                                     admin/products#show
#                                          PATCH    /admin/products/:id(.:format)                                                                     admin/products#update
#                                          PUT      /admin/products/:id(.:format)                                                                     admin/products#update
#                                          DELETE   /admin/products/:id(.:format)                                                                     admin/products#destroy
#                                     root GET      /                                                                                                 home#index
#                                 products GET      /products(.:format)                                                                               products#index
#                                  product GET      /products/:id(.:format)                                                                           products#show
#                           checkout_index GET      /checkout(.:format)                                                                               checkout#index
#                                          POST     /checkout(.:format)                                                                               checkout#create
#                           sync_all_carts POST     /carts/sync_all(.:format)                                                                         carts#sync_all
#                    variant_dropdown_cart GET      /carts/:id/variant_dropdown(.:format)                                                             carts#variant_dropdown
#                                sync_cart POST     /carts/:id/sync(.:format)                                                                         carts#sync
#                                    carts GET      /carts(.:format)                                                                                  carts#index
#                                     cart PATCH    /carts/:id(.:format)                                                                              carts#update
#                                          PUT      /carts/:id(.:format)                                                                              carts#update
#                                          DELETE   /carts/:id(.:format)                                                                              carts#destroy
#                             info_variant GET      /variants/:id/info(.:format)                                                                      variants#info
#                      add_to_cart_variant POST     /variants/:id/add_to_cart(.:format)                                                               variants#add_to_cart
#                guest_add_to_cart_variant POST     /variants/:id/guest_add_to_cart(.:format)                                                         variants#guest_add_to_cart
#                          buy_now_variant POST     /variants/:id/buy_now(.:format)                                                                   variants#buy_now
#                    guest_buy_now_variant POST     /variants/:id/guest_buy_now(.:format)                                                             variants#guest_buy_now
#                             cancel_order DELETE   /orders/:id/cancel(.:format)                                                                      orders#cancel
#                                   orders GET      /orders(.:format)                                                                                 orders#index
#                                          POST     /orders(.:format)                                                                                 orders#create
#                                    order GET      /orders/:id(.:format)                                                                             orders#show
#                                          GET      /account/orders(.:format)                                                                         orders#index
#                            account_index GET      /account(.:format)                                                                                account#index
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
#            rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
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
