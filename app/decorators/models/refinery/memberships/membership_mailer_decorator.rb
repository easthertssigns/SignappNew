Refinery::Memberships::MembershipMailer.class_eval do
  def member_email(email, member)
    @member = member

    @email = Refinery::Memberships::MembershipEmail[email]

    html = render_to_string :template => 'refinery/memberships/membership_mailer/email'

    #html = extract_images(html)
    text = html_to_text(html)

    mail(:to => member.email, :subject => @email.subject) do |format|
      format.text { render :text => text }
      format.html { render :text => html }
    end
  end

  def deliver_member_password_reset(member)
    email = member_password_reset_email(member)
    email.deliver
  end

  def email_password_reset(member)
    @token = member.reset_password_token
    @member = member
    mail(:to => member.email, :subject => "Password Reset Request")
  end


  def member_password_reset_email(member)
    @member = member

    @token = member.reset_password_token

    html = render_to_string :template => 'refinery/memberships/membership_mailer/email_password_reset'

    #html = extract_images(html)
    text = html_to_text(html)

    mail(:to => member.email, :body => html, :subject => "Password Reset Request", :content_type => 'text/html')
  end
end