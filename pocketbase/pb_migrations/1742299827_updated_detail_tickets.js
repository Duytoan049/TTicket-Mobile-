/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_341993654")

  // add field
  collection.fields.addAt(10, new Field({
    "hidden": false,
    "id": "number2607528692",
    "max": null,
    "min": null,
    "name": "movieId",
    "onlyInt": false,
    "presentable": false,
    "required": false,
    "system": false,
    "type": "number"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_341993654")

  // remove field
  collection.fields.removeById("number2607528692")

  return app.save(collection)
})
