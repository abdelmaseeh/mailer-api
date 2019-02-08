# README

## Mailer Api checker 

### overview
Check email if it already exists or it is a fake or mistyped one

### usage 
you can use it by making a post request to ```/api/v1/email_valid``` with 
email=test@example.com to request body.

### success and error messages
* **email exist :)** if email exist 
* **email does not exist as an SMTP domain** if not exist 

### used Gems and APIs 
* I use [mailboxlayer](https://mailboxlayer.com) as a 3rd party api
* I use `apipie-rails` GEM for the sake of API documentation


