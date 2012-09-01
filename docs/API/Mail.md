Mail
====
> Send e-mail with PHP via SMTP, sendmail or mail. Secure channel or unsecure channel, with your own server or a third party.

The `Mail` class is a simple PHPMailer wrapper. If you send email in several places you will find very handy to write a `mail.config.php` configuration file with all the parameters and then in your models or controllers just specify the recipient and write the email.

### Configuring the email.

The email settings are found in the `mail.config.php`. If your instance does not have this file yet just copy `instances/common/config/mail.config.php` to the same path within your instance and then `/rebuild` your project.

All the settings you write there will be used when you send an email. If you need to specify more PHPMailer attributes that are not present in the configuration, just add a key with the same name of the attribute and it will be set for you.

A couple of configuration examples are provided below:

* [Configure PHP Mail to send over Google Mail](#google-mail)
* [Configure PHP Mail to send over Amazon SES](#amazon-ses)

### Implementation:

Once the mail has been configured by filling the `mail.config.php` file, sending one is as simple as:

	$mail = new \Sifo\Mail();
	$mail->send( $to, $subject, $body )

And that's all you need to do.

### Sending custom emails using templates
Plain text emails are lovely, but companies like to include fancy logos, colors and pictures of kittens in every email they send. That's why HTML is the most used email format. Being that said, you will likely need to generate these cool emails using a dynamic template.

You can grab the contents of a smarty template and compile it in the middle of a controller execution. That is as simple as invoking a `$this->fetch( $template )` when you want to compile a template. This is a possible scenario:

	public function build()
	{
		$mail = new \Sifo\Mail();
		$to_email = 'dummy@dummy.com';
	
		// Let's grab a template (no matter what layout is using right now the controller)
		$to_email_template = 'email/registration_confirmation.tpl';
		// Some vars used inside the TPL need to be set:
		$this->assign( 'email', $to_email );
		$this->assign( 'verification_link', $verification_link );
	
		// Then we grab the HTML as the controller is going:
		$body = $this->fetch( $to_email_template );
		$subject = $this->translate( 'Confirm your new account' );
	
	 	// And send it:
		$mail->send( $to_email, $subject, $body ) );
	}
	


How to send email with PHP via Google Mail {#google-mail}
------------------------------------------
This is a sample file of a classic `mail.config.php` that sends email using Google Mail. If you use that service, you can copy and paste this with your credentials, this piece of code has sent millions of emails already :)

Have in mind that in order to send email via GoogleMail, SMTP has to be **manually enabled in your Google Mail settings**.

	<?php

	/**
	 * The key values must be PHPMailer attributes. If you remove attributes, defaults will be used
	 */
	$config['From'] 		= 'support@yourcompany.com';
	$config['FromName'] 	= 'My Company';
	$config['CharSet'] 		= 'utf-8';
	$config['ContentType']	= 'text/html';

	//  Method to send mail: ("mail", "sendmail", or "smtp").
	$config['Mailer'] 		= 'smtp';
	$config['Host']			= 'smtp.gmail.com';
	$config['Port']			= 465; // or 587

	// Options for SMTPSecure are "", "ssl" or "tls"
	$config['SMTPSecure']	= 'ssl';
	$config['SMTPAuth']		= true;
	$config['Username']		= 'myuser@google.com';
	$config['Password']		= 'YourPasswordXXXX';
	$config['Timeout']		= 10;
	$config['SMTPDebug']	= false;



How to send email with PHP via Amazon Simple Email Service (SES) {#amazon-ses}
----------------------------------------------------------------
This is an example on how to proceed to have a Sifo instance sending email via [Amazon SES](http://aws.amazon.com/ses/). The configuration can be recycled to set up any other SMTP service.

First, of all, you need an Amazon SES account:

* Login into your [Amazon Web Services, AWS](http://aws.amazon.com)
* Go to [SES](http://aws.amazon.com/ses/) and signup for the service
* Open the [SES console](https://console.aws.amazon.com/ses/home)
* Browse to `SMTP settings` and create a new user.
* Save the credentials
* After that there is a [new created user here](https://console.aws.amazon.com/iam/home?#s=Users)

Finally you need to specify at least one email address as the sender of your emails. To do so:

* Go to verified Senders
* Add a new address
* Click on the verification link sent to your address.

Then, to configure Sifo, these are the parameters you need to set up in your `mail.config.php` (should be in your instance `config` directory and you should have `/rebuild` your project :

	//  Method to send mail: ("mail", "sendmail", or "smtp").
	$config['Mailer'] 		= 'smtp';

	// SMTP settings. Put here your host. Amazon has already given you that.
	$config['Host']			= "email-smtp.us-east-1.amazonaws.com"; 
	$config['Port']			= 465; // Other ports may apply as well.

	// Options are "", "ssl" or "tls"
	$config['SMTPSecure']	= 'ssl';
	$config['SMTPAuth']		= true;
	$config['Username']		= 'XXXXXX';
	$config['Password']		= 'XXXxxXXxxXXXXxxXXXXXXX';
	
And that's it. With this now all your emails go through Amazon SES.