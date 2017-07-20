class ApplicationMailer < ActionMailer::Base
  default from: "'pavi' '<from@example.com>'"
  layout 'mailer'
end
