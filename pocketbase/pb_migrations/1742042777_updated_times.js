/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3599847527")

  // add field
  collection.fields.addAt(2, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_1956964795",
    "hidden": false,
    "id": "relation3219281744",
    "maxSelect": 1,
    "minSelect": 0,
    "name": "seats",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3599847527")

  // remove field
  collection.fields.removeById("relation3219281744")

  return app.save(collection)
})
