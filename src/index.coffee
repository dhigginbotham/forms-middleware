    
# mod depends
fs = require "fs"
path = require "path"
jade = require "jade"
_ = require "underscore"

# `includes` prefix path and `compile` path

# build default form object as a first-class fn, something 
# about `hot code` ;)
form = (req, opts) ->

  # form method
  @method = "get"

  # form title
  @title = null

  # action
  @action = null

  # id for form
  @id = null

  # form fields
  @forms = [
    # {type: "password", name: "password", id: "password", name: "password", label: "Password", value: null}
  ]

  # form buttons
  @buttons = [
    {type: "submit", name: "submit", id: "submit", name: "submit", class: "primary", std: "Submit"}
  ]

  # form csrf protection
  @csrf = if req.hasOwnProperty('csrfToken') == true then req.csrfToken() else null

  @framework = "bootstrap"

  # extend form, for dynamic opts
  if opts? then _.extend @, opts

  self = @
  
  @template = path.join __dirname, "..", "templates", self.framework + "-forms.jade"

  # loop through our forms and fix them for jade
  for form in @forms
    do (form) ->

      if form.value == "undefined" or typeof form.value == "undefined" or not form.value? then form.value = null
      
      if form.id == "undefined" or typeof form.id == "undefined" or not form.id? then form.id = null
      
      if form.label == "undefined" or typeof form.label == "undefined" or not form.label? then form.label = null

      # set default type to `text`
      if form.type == "undefined" or typeof form.type == "undefined" or not form.type? then form.type = "text"

      # apply fallback for `id` to `name`
      if form.name? and not form.id? then form.id = form.name

  @

# jade render method so we can get cool stuff on the client, yeah.
form::render = (fn) ->

  # persist this, so we're not doing anything tricky later  
  self = @

  # render our template with `jade.compile`
  template = jade.compile fs.readFileSync self.template, "utf8"

  # should be defined in middleware, not here.
  
  # set `this._rendered` to our template file
  # usage inside of a page:

  @_rendered = template self

  fn null, @_rendered
  
module.exports = form
