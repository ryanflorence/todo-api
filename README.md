TODO API!
=========

You love your Todo demos. Now you have an API to throw in the mix like a
grown up.

Find it on heroku (for now) at [http://high-robot-9464.herokuapp.com/][u]

RESTful API
-----------

### `POST /lists`

#### body

- `name` - The lists name

#### response

```javascript
{
  id: <id>,
  name: <name>,
  path: <path relative to host>
}
```

#### notes

All lists are destroyed after a week.

### `GET /lists`

#### response

```javascript
[
  {
    id: <id>,
    name: <name>,
    path: <path relative to host>
  },
  ...
]
```

### `GET /lists/:listID`

#### response

```javascript
{
  id: <id>,
  name: <name>,
  path: <path relative to host>,
  items: [item]
}
```

### `DELETE /lists/:listID`

#### response

`list deleted`

### `PUT /lists/:listID`

#### body

- `name` - The list's new name

#### response

```javascript
{
  id: <id>,
  name: <name>,
  path: <path relative to host>
}
```

### `POST /lists/:listID/items`

#### body

Typically:

- `description` - Description of the todo item
- `complete` - boolean if the item is complete or not

However, there is no schema at all, so you can store anything you want
in an item.

#### response

```javascript
{
  id: <id>,
  path: <path relative to host>
  description: <description>
  complete: <true/false>
  ...
}
```

### `GET /lists/:listID/items/:itemID`

#### response

```javascript
{
  id: <id>,
  path: <path relative to host>
  description: <description>
  complete: <true/false>
  ...
}
```

### `DELETE /lists/:listID/items/:itemID`

#### response

```javascript
'item deleted'
```

### `PUT /lists/:listID/items/:itemID`

#### body

Typically:

- `description` - Description of the todo item
- `complete` - boolean if the item is complete or not

However, there is no schema at all, so you can store anything you want
in an item.

#### response

```javascript
{
  id: <id>,
  path: <path relative to host>
  description: <description>
  complete: <true/false>
  ...
}
```

Contributing
------------

Run tests with `npm test`.


  [api]:https://github.com/rpflorence/todo-api/blob/master/test/api.coffee
  [u]:http://high-robot-9464.herokuapp.com/

