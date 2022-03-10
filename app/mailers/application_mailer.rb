class ApplicationMailer < ActionMailer::Base
  default from: ENV["MAILER_ENV"]
  layout "mailer"
end
