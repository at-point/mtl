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
- Mobile navigation: `data-mtl-nav`
- Select fields: `data-mtl-select`
- Collapsibles: `data-mtl-collapsible`
- Modals: `data-mtl-modal`

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

### Modals

Based on leanModal MTL adds turbolinks support as well as loading content over
XHR GET requests. This can be used to render partials into modal windows. For
markup details of the modal itself, please refer to the
[Materialize CSS: Modals][m-modals] documentation.

#### Simple modals

A modal usually consists of a trigger (via `data-mtl-modal="default"`) and the
corresponding modal content.

```html
<!-- Use data-mtl-modal="default" to enable as trigger, uses href or data-target -->
<a href="#modal" class="btn-flat" data-mtl-modal="default">Open Modal</a>

<div class="modal">
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

The (Rails) controller should be configured to only return a partial. The partial
can contain `data-mtl-modal="close"` triggers too.

```ruby
# Rails: your_controller.rb
def assignees_modal
  @assignees = context.assignees
  render partial: 'assignees_modal'
end
```

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

[material]: https://material.google.com/
[materialize]: http://materializecss.com/
[icons]: https://design.google.com/icons/

[m-select]: http://materializecss.com/forms.html#select
[m-collapsible]: http://materializecss.com/collapsible.html
[m-icons]: http://materializecss.com/icons.html
[m-buttons]: http://materializecss.com/buttons.html
[m-modals]: http://materializecss.com/modals.html
