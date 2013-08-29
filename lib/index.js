(function() {
  var form, fs, jade, path, _;

  fs = require("fs");

  path = require("path");

  jade = require("jade");

  _ = require("underscore");

  form = function(req, opts) {
    var self, _fn, _i, _len, _ref;
    this.method = "get";
    this.title = null;
    this.action = null;
    this.id = null;
    this.forms = [];
    this.buttons = [
      {
        type: "submit",
        name: "submit",
        id: "submit",
        name: "submit",
        "class": "primary",
        std: "Submit"
      }
    ];
    this.csrf = req.hasOwnProperty('csrfToken') === true ? req.csrfToken() : null;
    this.framework = "bootstrap";
    if (opts != null) {
      _.extend(this, opts);
    }
    self = this;
    this.template = path.join(__dirname, "..", "templates", self.framework + "-forms.jade");
    _ref = this.forms;
    _fn = function(form) {
      if (form.value === "undefined" || typeof form.value === "undefined" || (form.value == null)) {
        form.value = null;
      }
      if (form.id === "undefined" || typeof form.id === "undefined" || (form.id == null)) {
        form.id = null;
      }
      if (form.label === "undefined" || typeof form.label === "undefined" || (form.label == null)) {
        form.label = null;
      }
      if (form.type === "undefined" || typeof form.type === "undefined" || (form.type == null)) {
        form.type = "text";
      }
      if ((form.name != null) && (form.id == null)) {
        return form.id = form.name;
      }
    };
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      form = _ref[_i];
      _fn(form);
    }
    return this;
  };

  form.prototype.render = function(fn) {
    var self, template;
    self = this;
    template = jade.compile(fs.readFileSync(self.template, "utf8"));
    this._rendered = template(self);
    return fn(null, this._rendered);
  };

  module.exports = form;

}).call(this);
