


--------------------

# screen-object 
screen-object is a ruby gem. It is a wrapper on top of Appium. This gem helps create screen objects for automating ios and android mobile apps. screen-object methods interact with the elements on the screen. 

### Software Requirements 
This gem is tested on Ruby 2.1.3, Ruby 2.1.5 and Ruby 2.3.0

### Gem Dependencies
Other gems used by screen-object 

1. rake
2. require_all
3. rspec
4. cucumber
5. appium_lib
6. page_navigation
7. childprocess

### Setup Instructions

Add the gem to gemfile
  
````ruby
gem 'screen-object'
````

Add the gem to supporting file

````ruby
require 'screen-object'
````
 
Include screen-object module to the class
 
 ````ruby
include ScreenObject
````

After including this screen-object module, numerous methods will be added in to your class that allow you to define your screen. For the login page you might design your test in following way:

Calling the text_field and button methods. To login, we could simply write the following code:


````ruby
class LoginScreen

    include screen-object
    # This will add several methods to our page object that allow us to interact with the items on the screen.

        text_field(:username, "name~username”)
        text_field(:password, "name~password”)
        button(:login, "name~login”)

        def enter_username(username)
            self.username = username
        end

        def enter_password(password)
            self. password = password
        end

        def click_login_button
            login
        end

    end
````

Now , you can call those methods into actual step_definition file

````ruby
    on(LoginScreen).enter_username(“testuser”)
    on(LoginScreen).enter_password(“secrect”)
    on(LoginScreen).click_login_button
````

### RoadMap
1. Add collection methods
2. Wiki documentation page
3. Add device specific methods to the accessors
4. Make the gem tool agnostic and support other tools based on demand

### Contributors:
We welcome your interest in Capital One’s Open Source Projects (the “Project”). Any Contributor to the project must accept and sign a CLA indicating agreement to the license terms. Except for the license granted in this CLA to Capital One and to recipients of software distributed by Capital One, you reserve all right, title, and interest in and to your contributions; this CLA does not impact your rights to use your own contributions for any other purpose.

Link to [CLA] (https://docs.google.com/forms/d/19LpBBjykHPox18vrZvBbZUcK6gQTj7qv1O5hCduAZFU/viewform)

This project adheres to the [Open Source Code of Conduct] (http://www.capitalone.io/codeofconduct/). By participating, you are expected to honor this code.
 

