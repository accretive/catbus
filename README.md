# Catbus
Catbus is an off canvas responsive menu system.


## Dependencies
* Node
* Bower


## Getting Started
1. clone: `$ git clone https://github.com/accretive/catbus`
3. go: `$ cd catbus`
5. install: `$ npm install && bower install`
6. run: `$ npm start`
7. visit: http://localhost:9000/


## Demo
Visit [our demo page](http://accretive.github.io/catbus) to see the catbus in action.


## Basic Usage
Catbus uses require.js AMD declarations for loading.

```html
  <head>
    <!-- Meta tags to keep the viewport the right size on mobile devices -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, \
    maximum-scale=1.0, user-scalable=no, minimal-ui">

    <!-- Requirejs and Catbus -->
    <script src="requirejs/requirejs.js" data-main="catbus">

    <!-- Catbus CSS -->
    <link rel="text/css" href="catbus.css">
  </head>
```

```html
  <div js-catbus class="catbus">
    <div class="catbus_container">

      <div class="catbus__nav">

        <!-- optional button, depending on your usage -->
        <button js-catbus-button class="catbus__button">Button!</button>

        <div>
          <!-- your nav content goes here -->
        </div>

      </div>

      <div class="catbus__section">

        <div>
          <!-- your page goes here -->
        </div>

      </div>

      <img js-catbus-tail class="catbus__tail"
        src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7">

    </div>
  </div>
```

## Options
Catbus has 3 position options available.  By adding the classes `catbus-top`,
`catbus-left` or `catbus-right` to the body tag you control what side of the
screen the catbus enters from.
