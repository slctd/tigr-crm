class CrmMailer < ActionMailer::Base
  default from: "no-reply@crm.tigr.biz"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.crm_mailer.export.subject
  #
  def export(user, file_link)
    @file_link = file_link
    mail to: user.email
  end
end
