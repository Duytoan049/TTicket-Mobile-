/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3599847527")

  // remove field
  collection.fields.removeById("json1845068729")

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3599847527")

  // add field
  collection.fields.addAt(2, new Field({
    "hidden": false,
    "id": "json1845068729",
    "maxSize": 0,
    "name": "reserved_seat",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  return app.save(collection)
})
