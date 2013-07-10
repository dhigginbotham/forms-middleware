# andForms
The purpose of `andForms` is to give an easy way to build forms from an Object, so you can either build out static middleware or pull from mongodb, mysql, etc..

### Features
- built in csrf by default, you will need to use `app.use express.csrf()` read more [`connect`](http://www.senchalabs.org/connect/csrf.html)
- 100% coffee-script, hate it or love it
- underscore library to deep extend form objects
- flexible

### Install
```npm install git+https://github.com/dhigginbotham/andForms --save```

### Usage
Here's how you use andForms as a middleware in your express app

```coffee

  ### middleware.coffee ###
  form = require "andForms"

  middle = {}

  middle.account = (req, res, next) ->

    account =
      method: "post"
      title: "Login Form"
      id: "account"
      action: "login"
      forms: [
        {type: "text", name: "first", id: "first", name: "first", label: "First Name", value: if req.user? then req.user.first_name else null}
        {type: "text", name: "last", id: "last", name: "last", label: "Last Name", value: if req.user? then req.user.last_name else null}
        {type: "text", name: "phone", id: "phone", name: "phone", label: "Phone", value: if req.user? then req.user.phone else null}
        {type: "text", name: "email", id: "email", name: "email", label: "Email", value: if req.user? then req.user.email else null}
      ]

    forms = new form req, account
    forms.render()

    if forms._rendered? then res.locals.accountForm = forms._rendered
    next()

  middle.login = (req, res, next) ->

    login =
      method: "post"
      title: "Login Form"
      id: "login"
      action: "login"
      forms: [
        {name: "username", label: "Username", value: null}
        {type: "password", name: "password", label: "Password", value: null}
      ]

    forms = new form req, login
    forms.render()

    if forms._rendered? then res.locals.loginForm = forms._rendered
    next()

  module.exports = middle

```

```coffee

  ### app.coffee ###

  express = require "express"
  app = module.exports = express()

  # statics, favicon poo
  app.use express.favicon()
  app.use express.static conf.app.paths.assets
  app.use express.csrf()

  forms = require "./middleware"

  app.get "/login", forms.loginForm, (req, res) ->
    res.render "pages/account",
    title: "login page"

```

```jade

  //- account.jade

  extends ../layout

  block content
    .row
      != accountForm  

```

### Roadmap
- finish up the front-end templating

### License
```md

The MIT License (MIT)

Copyright (c) 2013 David Higginbotham 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

```
