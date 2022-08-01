#---
# Excerpted from "Agile Web Development with Rails 6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails6 for more book information.
#---
require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Depot
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # monkey patching to resolve the issue of action mailbox inbound email sending empty attachment
    config.to_prepare do
      Rails::Conductor::ActionMailbox::InboundEmailsController.class_eval do
        private

        def new_mail
          Mail.new(params.permit!.except(:attachments).to_h).tap do |mail|
            mail[:bcc]&.include_in_headers = true
            noBlankParams = params[:attachments].to_a.reject { |p| p.blank? }
            p ">>> noBlankParams: #{noBlankParams}"
            noBlankParams.each do |attachment|
              mail.add_file(filename: attachment.original_filename, content: attachment.read) if !attachment.blank?
            end
          end
        end
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.middleware.use I18n::JS::Middleware
  end
end