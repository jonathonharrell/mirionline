'use strict'

# this file should import all the related .data files for character structure
# and merge itself together before exporting
# the "Character" model will apply the options here for validations

d     = require "../data-helper"
names = d.import("names").names
_     = require "lodash"

CharacterStruct =
  firstName:
    options: names.first
  surname:
    options: names.last
  gender:
    options: ["male", "female"]
  hair: # todo, pull from hair-colors.json where source includes natural (as dyes can provide other colors)
    color:
      options: [
        "black",
        "dark brown",
        "chestnut",
        "auburn",
        "copper",
        "red",
        "strawberry",
        "light blonde",
        "dark blonde",
        "golden blonde",
        "grey",
        "white"
      ]
    style: # todo pull from hair-styles.json where source includes natural (as barbers can provide new styles)
      options: [
        male: [
          "textured"
          "bald"
        ]
        female: [
          "textured"
          "bald"
        ]
      ]

module.exports = exports = CharacterStruct
