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

module.exports = exports = CharacterStruct
