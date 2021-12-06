class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.new_message.subject
  #
  def new_message
    @message_from = params[:message_from]
    @room = params[:room]

    mail(to: params[:message_to], subject: 'New message')
  end
end
