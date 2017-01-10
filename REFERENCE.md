# MTL: Materializer

Materializer is an opinionated toolkit for Rails to simplify building user
interfaces that are based on [Material Design][material] and
[Materialize CSS][materialize].




## Using MTL

MTL provides three different parts:

- [Materialize CSS][materialize] and extensions for the asset pipeline,
- [Materialize][materialize] JS wrappers for the asset pipeline (and support turbolinks),
- and {Mtl::Rails::ViewHelpers Rails view helpers} to render common components

The first step is to add `mtl` to your `Gemfile`:

```ruby
gem 'mtl', git: 'https://github.com/at-point/mtl'
```

Then run `bundle` and then afterwards the install generator to copy customizable
assets to your project:

```
./bin/rails generate mtl:install [--skip-simple-form]
# This copies the following files:
#    - app/assets/stylesheets/mtl.scss
#    - app/assets/stylesheets/mtl/_color.scss
#    - app/assets/stylesheets/mtl/_variables.scss
#    - config/initializers/simple_form.rb
```

Last but not least change your `application.css` to include:

```
//= require mtl
```




## Layouts

MTL provides two layouts:

- a default application layout, with a header and a sidebar
- a single layout with centered content


### Default application Layout

This layout is suited for standard application / backends with a sidebar for
the primary navigation.

![default layout](images/layout-default.jpg)

```html
<body class="mtl-layout-default">
  <header id="nav-menu" class="mtl-layout-default-header side-nav fixed">
    <!-- your nav collection -->
  </header>
  <main>
    <%= mtl_header 'Dashboard' %>
    <div class="mtl-layout-default-content">
      <!-- your content -->
    </div>
  </main>
</body>
```

#### Floating action button

If you use a `.fixed-action-btn` and {Mtl::Rails::ViewHelpers#mtl_button_floating mtl_button_floating}
inside `.mtl-layout-default-header`, it will be positioned to right lower side
of the header.

![fixed action button](images/fixed-action-button.jpg)

```html
<%= mtl_header 'User' do %>
  <div class="fixed-action-btn">
    <%= mtl_button_floating :add, new_user_path, class: 'btn-large' %>
  </div>
<%- end %>
```

### Single Layout

A centered single column layout, e.g. for login screens or other standalone
views.

![single layout](images/layout-single.jpg)

```html
<body class="mtl-layout-single">
  <header class="mtl-layout-single-header">
      <img src="your-logo.svg">
  </header>
  <main class="mtl-layout-single-content">
    <!-- your content, e.g. a card: -->
    <div class="row">
      <div class="col s12 m8 offset-m2">
        <div class="card">
          <!-- ... -->
        </div>
      </div>
    </div>
  </main>
</body>
```




## CSS extensions


### Suffixes for single line inputs

We enabled the use of static suffixes for input fields with following types: text, password, email, url, time, date, datetime, datetime-local, tel, number and search.

These can be used for units like currencies and more:

```html
<div class="input-field has-suffix">
  <input type="text"/>
  <label>Label</label>
  <div class="suffix">CHF</div>
</div>
```

If you use simple_form, check out our component extension: [SimpleForm/Components/Suffix](SimpleForm/Components/Suffix.html).


### Radio buttons

We extended the default radio buttons with a horizontal mode. This will align radio buttons in one horizontal line, instead of breaking them to new lines.

```html
<div class="input-field radio_buttons radio_buttons--horizontal">
  <p class="radio">
    <input class="radio_buttons" type="radio">
    <label class="collection_radio_buttons">Mr.</label>
  </p>
  <p class="radio">
    <input class="radio_buttons" type="radio">
    <label class="collection_radio_buttons">Mrs</label>
  </p>
  <label class="radio_buttons">Title</label>
</div>
```


### Buttons

We added **square-button** to display an icon in a squared button.

Example:

```html
<div class="row">
  <a class="btn-flat btn-square grey-text col left">
    <%= mtl_icon :attach_file %>
  </a>
  <a class="btn-flat btn-square grey-text col left">
    <%= mtl_icon :format_align_left %>
  </a>
</div>
```

...will convert to:

![squared buttons](images/squared-buttons.jpg)


### Grid

We extended the grid system with some helper classes, removing some of the native padding of columns if needed.

- **no-pad** will remove all padding of a *col* element
- **no-pad-left** will remove the left padding of a *col* element
- **no-pad-right** will remove the right padding of a *col* element

Example:

```html
<div class="row">
  <div class="col no-pad s12">
    This column won't present any padding to its sides.
  </div>
</div>

<div class="row">
  <div class="col no-pad-left s6">
    This column won't present any padding to its LEFT side.
  </div>
  <div class="col no-pad-right s6">
    This column won't present any padding to its RIGHT side.
  </div>
</div>
```

As a generic helper, we added a scroll class to it too, which you can use on a .row, or some other wrapping div:

Example:

```html
<div class="row scroll-y" style="height: 400px;">
  This content will be scrollable if its size exceeds the specified height of 400px.
</div>
```


### Tables

We added two modes for tables: **no-side-padding** and **compressed**:

- The class *no-side-padding* will remove the cell padding to the left of the first entry and the right one of the last.
- The class *compressed* will reduce the vertical cellpadding, compressing the contents of a table.

Examples:

```html
<table class="bordered no-side-padding compressed">
  <tbody>
    <tr>
      <td>Lorem</td>
      <td>Ipsum</td>
      <td class="right">Sit amet</td>
    </tr>
  </tbody>
</table>
```

...will convert to:

![table modes](images/table-modes.jpg)


### Files/Downloads

To show a list of files / downloads, you can use following markup:

```html
<a class="card-panel" href="/path/to/file.pdf" title="Document Dolorem.jpg">
  Document Dolorem
  <span>
    <i class="material-icons red-text">picture_as_pdf</i>
    PDF
  </span>
  <i class="close material-icons">close</i>
</a>
<a class="card-panel" href="..." title="file.xlsx">
  <strong>Lots of I don't know what, what is this?</strong>
  file.xlsx
  <span class="grey-text">
    <i class="material-icons blue-text">insert_drive_file</i>
    Image
  </span>
  <i class="close material-icons">close</i>
</a>
<a class="card-panel card-panel-image" href="..." style="background-image: url('http://i.giphy.com/l2JJsnBRsvr9bs5RC.gif');" title="This content will be hidden...">
  <strong>This content will be hidden...</strong>
  hidden.gif
  <span class="grey-text">
    <i class="material-icons blue-text">insert_drive_file</i>
    Image
  </span>
  <i class="close material-icons">close</i>
</a>
```

This will be rendered into a neat and responsive listing of files with previews for images:

![collection-files](images/collection-files.jpg)

The files inside a collection can be previewed by appending `data-mtl-document-modal="open"` and `data-mtl-document-name="file.jpg"`, e.g:

```html
  <a class="card-panel" href="/path/to/file.pdf" title="Document Dolorem.jpg" data-mtl-document-modal="open" data-mtl-document-name="Document Dolorem.jpg">
    <!-- ... -->
  </a>
```

The preview displays images (jpg, png, bmp, gif) and PDFs if there is support for an inline
PDF viewer. If the file cannot be previewed, a modal with a download button is shown.
The modal dialog for non-previewable files can be customized by overriding the `MTL.templates.no_preview`
template.

## Rails view helpers

![Buttons](images/buttons.jpg)

### `Mtl::Rails::ViewHelpers`

There are Rails view helpers for icons, buttons and more, see
{Mtl::Rails::ViewHelpers}.




## JavaScript

MTL provides unobstrusive wrappers that work with (and without) Rails' Turbolinks.
To get started add the following sprockets require to your primary JS file:

```js
//= require mtl
```

When you are using Turbolinks, this require statement must be added after
turbolinks.

### Supported Features

The following JS helpers from [Materialize CSS][materialize] are supported:

- Wave effects (enabled for Turbolinks)
- Text fields (support for Turbolinks)
- [Mobile navigation: `data-mtl-nav`](#label-Mobile+navigation)
- [Select fields: `data-mtl-select`](#label-Select+fields)
- [Tabs: `data-mtl-tabs`](#label-Tabs)
- [Collapsibles: `data-mtl-collapsible`](#label-Collapsible)
- Dropdowns: `data-mtl-dropdown`
- [Modals: `data-mtl-modal`](#label-Modals)
- [Pinned table of contents (with scrollSpy): `data-mtl-toc`](#label-Table+of+Contents)

**Note:** at the time of writing not all JS helpers are supported. New wrappers
are added step by step over time.

### Mobile navigation

For elements that use `data-mtl-nav="side"`, like those generated by the
{Mtl::Rails::ViewHelpers#mtl_header mtl_header}, the `sideNav()` method is
automatically executed.

![Mobile Nav Example](images/mobile_nav.jpg)

**Example markup**

```html
<div class="side-nav" id="nav">
  <!-- side nav -->
</div>
<nav>
  <a class="left hide-on-large-only" data-activates="nav" data-mtl-nav="side" href="#nav">
    <i class="material-icons">menu</i>
  </a>
  <h1 class="page-title">My Account</h1>
</nav>
```

### Select fields

Supports handling and styling of Material CSS [select form fields][m-select], one
option is also a multi select drop down.

#### Single select

![Single select](images/select.gif)

```html
<select data-mtl-select>
  <option value="" disabled selected>Choose your option</option>
  <option value="1">Option 1</option>
  <option value="2">Option 2</option>
  <option value="3">Option 3</option>
</select>
```

#### Multi select

The first option acts as a _all_ option, that is correctly selected, deselected
and reselected based on user input.

![Single select](images/select_multi.gif)

```html
<select data-mtl-select="multiple" multiple>
  <option value="all"selected>All</option>
  <option value="1">Option 1</option>
  <option value="2">Option 2</option>
  <option value="3">Option 3</option>
</select>
```

### Tabs

Support for the [tabs from Materialize CSS][m-tabs], basically just some Turbolinks
hooks again, usage as follows:

```html
<ul class="tabs" data-mtl-tabs>
  <!-- standard materialize tab code ... -->
</ul>
```

### Collapsible

Adds support for the [collapsibles from Materialize CSS][m-collapsible] within
Turbolinks and adds a special addition: the `data-mtl-collapsible-toggle`.

![Collapsible](images/collapse.gif)

#### Accordion

The markup is exactly the same, except for `data-mtl-collapsible="accordion"`,
instead of `data-collapsible="accordion"`, this is required to support turbolinks
and because Materialize CSS binds directly to the `.collapsible` class.

```html
<ul class="collapsible" data-mtl-collapsible="accordion">
```

#### Expandable

Like for the accordion, the markup remains the same, simply use
`data-mtl-collapsible="expandable"`.

```html
<ul class="collapsible" data-mtl-collapsible="expandable">
```

#### Toggle

This allows to have an external trigger to toggle between the first and last
element of a `<ul class="collapsible">`. The required markup is as follows:

![Collapsible](images/collapse_toggle.gif)

The trigger element receives the class `.active` when the last element is shown
and `.active` is removed otherwise. As usual an item can be pre-opened with
adding the class `.active` to the corresponding `.collapsible-header` element,
by default the first item is open.

```html
<!-- Reference the .collapsible you want to toggle. -->
<div data-mtl-collapsible-toggle="#menu">Trigger</div>

<!-- Clicking on "Trigger" toggles between the App Menu Options and the
     User Menu Options. The headers are hidden. -->
<ul class="collapsible" id="menu">
  <li>
    <div class="collapsible-header">App</div>
    <div class="collapsible-body">
      ...App Menu Options
    </div>
  </li>
  <li>
    <div class="collapsible-header">User</div>
    <div class="collapsible-body">
      ...User Menu Options
    </div>
  </li>
</ul>
```

### Dropdowns

One of the more common uses of dropdowns is in the more menu items, where additional
actions are hidden within three dots.

![Dropdown](images/dropdown.gif)

Currently the width of the dropdown must be actively defined, when icons are used,
otherwise it can be left off. The trigger element simply requires a `data-mtl-dropdown`
and the `href` should point to the actual dropdown content.

There is also a Rails helper, see {Mtl::Rails::ViewHelpers#mtl_button_more}.

```html
<!-- Creates a button on the right, can be used in cards too, there is also
     a Rails helper #mtl_button_more that generates this markup for you -->
<div class="btn-more-wrapper">
  <a href="#dropdown" class="btn-flat btn-more">
    <i class="material-icons">more_vert</i>
  </a>
</div>

<!-- The dropdown content -->
<ul id="dropdown" class="dropdown-content">
  <li>
    <a href="...">
      <i class="material-icons">archive</i>
      Archive
    </a>
  </li>
  <!-- ... -->
</ul>
```

### Modals

Based on MTL modals, adds turbolinks support as well as loading content over
XHR GET requests. This can be used to render partials into modal windows. For
markup details of the modal itself, please refer to the
[Materialize CSS: Modals][m-modals] documentation.

#### Inline modals

A modal usually consists of a trigger and the corresponding modal content.
The modal is executed as such, by adding data-mtl-modal="inline" to its tag
or by manually firing the modal creation via the help of Materialize

```html
<a href="#modal1" class="btn-flat">Open Modal</a>

<div class="modal" id="modal1" data-mtl-modal="inline">
  <div class="modal-content">
    <h4>Your modal</h4>
    <p>Example modal.</p>
  </div>
  <div class="modal-footer">
    <!-- Use data-mtl-modal="close" to add a close button -->
    <a href="#close" class="btn-flat modal-action" data-mtl-modal="close">
      Close
    </a>
  </div>
</div>
```

#### XHR modals

To load content for the modal via XHR the trigger must be created as usual
with the `data-mtl-modal="xhr"` marker. The `href` in that case indicates the
resource to load via `$.load`. Behind the scenes an empty modal is generated,
that is loaded on open. No additional markup is required in that case.

```html
<a href="/your_controller/assignees" data-mtl-modal="xhr">
  Change assignee
</a>
```

Materialize also offers some control classes for the modal dialogs. As an XHR dialog
is based on a fixed template, there's no control on the wrapping element and those
classes can't be manually added. To solve this issue, you can use the optional data
attribute `data-mtl-modal-class` which can contain any custom class, that will be applied
to the wrapping modal element (in our case, the `<div class="modal"></div>`).
Example:

```html
<a href="/your_controller/users/new" data-mtl-modal="xhr" data-mtl-modal-class="modal-fixed-footer">
  Add user
</a>
```

Resulting HTML:

```html
<div class="modal modal-fixed-footer">
  <!-- XHR content -->
</div>
```

The (Rails) controller should be configured to only return a partial. The partial
can contain `data-mtl-modal="close"` triggers too.

```ruby
# Rails: your_controller.rb
def assignees_modal
  @assignees = context.assignees
  render partial: 'assignees_modal'
end
```

### Table of Contents

Based on the provided [scrollspy][m-scrollspy] and [pushpin][m-pushpin] methods
the MTL table of content behaviour automatically creates a dynamic ToC, based on
the current page content.

A ToC entry is indicated by adding `data-mtl-section="Title"` and then is
automatically added in the order of appearance on the site to the
`ul[data-mtl-toc]` element. Any content within `data-mtl-toc` is completely
replaced.

```html
<div class="row" data-mtl-section="Introduction">
  <!-- content -->
</div>
<div class="row" data-mtl-section="Structure">
  <!-- content -->
</div>
<div class="row" data-mtl-section="Other">
  <!-- content -->
</div>

<!-- ToC element: an empty ul with class="table-of-contents" -->
<ul class="table-of-contents" data-mtl-toc="pin"></ul>
```

Using `data-mtl-toc="pin"` makes use of the pushpin plugin to pin the ToC
element to the top of the screen.

### Helper: `data-mtl-href`

This utility helps linking rows from a table or ul to open a detail page.

```html
<tr data-mtl-href="<%= user_path(@user) %>">
  <td><img ...></td>
  <td><%= @user.first_name %></td>
  <td><%= @user.last_name %></td>
  <td><%= mail_to @user.email %></td>
  <td>
    <%= mtl_button_flat "Delete", user_path(@user), method: 'delete' %>
  </td>
</tr>
```

### Helper: `data-mtl-submit`

This utility allows submitting a form which is not a parent of the element.
Useful for buttons in the header which act on a form defined in the content section.

The form is targeted by a CSS selector.

```html
<a href="#" data-mtl-submit="#my-form">Save</a>
<form id="my-form" action="/" method="POST">
    <input name="email" type="email"/>
</form>
```

### JS Helper: `MTL.fileIcons`

Utility that returns the exact same content that Mtl.fileIcons, but in Javascript

```javascript
MTL.fileIcons['pdf'] # returns ['picture_as_pdf', 'red-text']
```

### JS Helper: `MTL.icon`

JS equivalent of the mtl_icon helper in ruby. Returns HTML

```javascript
MTL.icon('picture_as_pdf', { class: 'red-text' })
```

### JS Helper: `MTL.fileIcon`

JS helper to resolve a filename to a mime-type icon. Returns HTML

```javascript
MTL.fileIcon('a_picture.jpg', { size: 'large' })
```

There are distinct icons for `pdf, png, jpg, gif, bmp` other file types are
resolved to a generic file icon.

### JS Helper: `MTL.renderTemplate`

A very basic template registry for lodash templates, it compiles registered templates
once and then caches them for efficiency.

A template can be defined and used like:

```javascript
MTL.templates.my_template = "<div>Hello <%= name %></div>";
MTL.renderTemplate('my_template', { name: 'Dr. Who' })
```

[material]: https://material.google.com/
[materialize]: http://materializecss.com/
[icons]: https://design.google.com/icons/

[m-select]: http://materializecss.com/forms.html#select
[m-collapsible]: http://materializecss.com/collapsible.html
[m-icons]: http://materializecss.com/icons.html
[m-buttons]: http://materializecss.com/buttons.html
[m-modals]: http://materializecss.com/modals.html
[m-tabs]: http://materializecss.com/tabs.html
[m-scrolllspy]: http://materializecss.com/scrolllspy.html
[m-pushpin]: http://materializecss.com/pushpin.html
