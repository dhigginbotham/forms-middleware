# mod depends
fs = require "fs"
path = require "path"
jade = require "jade"
_ = require "underscore"

# `includes` prefix path and `compile` path
includes = "./includes"
compile = path.join __dirname, includes, "form.jade"

# build default form object as a first-class fn, something 
# about `hot code` ;)
form = (opts) ->

  # form method
  @method = "get"

  # form title
  @title = null

  # action
  @action = null

  # id for form
  @id = null

  # form fields
  @forms = []

  # form buttons
  @buttons = [
    {type: "submit", name: "submit", id: "submit", name: "submit", class: "primary", std: "Submit"}
    # {type: "cancel", name: "cancel", id: "cancel", name: "cancel", class: "secondary", std: "Cancel"}
  ]

  # form csrf protection
  @_csrf = null

  # extend form, for dynamic opts
  if opts? then _.extend @, opts

  @

# jade render method so we can get cool stuff on the client, yeah.
form::render = () ->

  # persist this, so we're not doing anything tricky later  
  self = @

  # render our template with `jade.compile`
  template = jade.compile fs.readFileSync compile, "utf8"

  # should be defined in middleware, not here.
  
  # set `this._rendered` to our template file
  # usage inside of a page:

  #   != res.locals.whateverYouNamedIt
  @_rendered = template self
  
module.exports = form
