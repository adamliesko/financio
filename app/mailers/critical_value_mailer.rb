class CriticalValueMailer< MandrillMailer::MessageMailer
  default from: 'notification@financio.com'

  def notification(account)
    mandrill_mail subject: "Critial value has been reached on account #{account.name}",
                  to: account.user.email,
                  text: "Your total balance on account #{account.name} is now #{account.total}.",
                  important: true,
                  inline_css: true
  end

  #handle_asynchronously :notification
end