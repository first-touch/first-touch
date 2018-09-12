class CustomDeviseMailer < Devise::Mailer
  helper :account_management # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer'
end
