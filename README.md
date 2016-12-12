# FOUNDATION FOR EMAILS RAILS STARTER

Coding html emails in rails env.
It uses Foundation for Emails ([inky-rb](https://github.com/zurb/inky-rb)) as templating and [letter_opener](https://github.com/ryanb/letter_opener) gem to preview emails in the browser.
This repo is already scaffolded for foundation for emails using using `rails g inky:install`, so you don't have to worry about that. Just code your inky email, add add your custom styles to `foundation_emails.scss`

### Requirements
This was only tested in
* `Rails 5.0^`
* `ruby 2.3.1p112 (2016-04-26 revision 54768)`

### setup

* `bundle install`
* `rails s`
* go to `localhost:3000/rails/mailers` to display a list of the current emails.

### Create an email
First, create your mailer controller (is it a controller? actually have no idea) that lives inside `app/mailers/` caller `badjoras_mailer.rb`, it should look like this

```Ruby
class BadjorasMailer < ApplicationMailer
  def badjoras(user)
    @user = user
    mail(to: @user, subject: 'Test') do |format|
      format.mjml
    end
  end
end
```

Secondly, create a corresponding view `badjoras.html.inky` file in the `app/views/badjoras_mailer` (it should match the controller name)

```ERB
<container>
	<row>
	  	<columns large="6"><h1 class="u-color-brand">Hello</h1></columns>
	  	<columns large="6"><%= @name %> to Foundation Badjoras</columns>
	</row>
</container>
```

and you can use partials 🎊
```ERB
<container>
	<!-- header partial located at ./app/views/badjoras_mailer/ -->
	<%= render partial: 'badjoras_header' %>
	<row>
	  	<columns large="6"><h1 class="u-color-brand">Hello</h1></columns>
	  	<columns large="6"><%= @name %> to Foundation Badjoras</columns>
	</row>
</container>
```


Finally in order to preview the email in the browser, add this two magic lines to `development.rb`
```Ruby
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :letter_opener
```

and precompile the sass file (yes you can your sass) with this one:
```Ruby
# ./config/initializers/assets.rb
Rails.application.config.assets.precompile += %w( foundation_emails.css )
```


then create a preview file `badjoras_mailer_preview.rb`inside `test/mailers/previews`, it should look like this

```Ruby
# Preview all emails at http://localhost:3000/rails/mailers/
class BadjorasrMailerPreview < ActionMailer::Preview
  def badjoras
    BadjorasMailer.badjoras('Teste Name')
  end
end
```
*Uff that's a wrap*


### What if I need more than one email template
Oh boy you're developer/engineer friend is not going to like this but at the time of writing I didn't figure it out a way of reusing this piece of code, so yes you have to duplicate. I'll updated this file when I have time to check that out.



### Thanks
* To the folks at http://foundation.zurb.com/ for helping fighting the HTML email development war.
* Hugo Giraudel for the [inspiring article](http://dev.edenspiekermann.com/2016/06/02/using-mjml-in-rails/) that made create a repo for [MJML Setup](https://github.com/renatodeleao/mjml-rails-starter-for-designers) and replicating it here Foundation for Emails.
* To the internet, making designers navigate upstream the developer river, even without having a single clue of what they're doing. (Sry I don't remember the url of the 100 article + stackoverflow questions)


### Notes
* Found this repo name offensive and misleading relative to the designer working class? Shoot me a tweet, I might read it while taking a big `rake db:dump` 😎.