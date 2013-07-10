form = require "./"

middle = {}

middle.account = (req, res, next) ->

  account =
    method: "post"
    title: "Login Form"
    id: "account"
    route: "login"
    forms: [
      {type: "text", name: "first", id: "first", name: "first", label: "First Name", value: if req.user? then req.user.first_name else null}
      {type: "text", name: "last", id: "last", name: "last", label: "Last Name", value: if req.user? then req.user.last_name else null}
      {type: "text", name: "phone", id: "phone", name: "phone", label: "Phone", value: if req.user? then req.user.phone else null}
      {type: "text", name: "email", id: "email", name: "email", label: "Email", value: if req.user? then req.user.email else null}
    ]
    _csrf: req.session._csrf

  forms = new form account
  forms.render()

  if forms._rendered? then res.locals.accountForm = forms._rendered
  next()

middle.login = (req, res, next) ->

  login =
    method: "post"
    title: "Login Form"
    id: "login"
    route: "login"
    forms: [
      {type: "text", name: "username", id: "username", name: "username", label: "Username", value: null}
      {type: "password", name: "password", id: "password", name: "password", label: "Password", value: null}
    ]
    _csrf: req.session._csrf

  forms = new form login
  forms.render()

  if forms._rendered? then res.locals.loginForm = forms._rendered
  next()

module.exports = middle
