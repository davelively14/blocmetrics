# Blocmetrics

[![Build Status](https://travis-ci.org/davelively14/blocmetrics.svg?branch=master)](https://travis-ci.org/davelively14/blocmetrics)[![Coverage Status](https://coveralls.io/repos/github/davelively14/blocmetrics/badge.svg?branch=master)](https://coveralls.io/github/davelively14/blocmetrics?branch=master)

How to set it up:


```javascript
var blocmetrics = {};

blocmetrics.report = function(eventName) {
  var event = {event: { name: eventName }};

  var request = new XMLHttpRequest();
  request.open("POST", "http://localhost:3000/api/events", true);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(event));
};
```

More to follow.

TODOs:
- ADD: Add admin functionality
  - Use `Pundit`

Changelog:
- ADD: Authorization to redirect users away from unauthorized logins
  - `:before_action` hook on RegisteredApplicationsController
