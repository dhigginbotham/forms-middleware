andForms
========
make easy forms with Express middleware an objects -- still needs some work, send a PR or an issue if you feel the urge ;)


# Middleware Usage:
```
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
```
