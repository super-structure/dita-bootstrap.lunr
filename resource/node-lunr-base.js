/*
 *  This file is part of the DITA-OT Bootstrap Lunr project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

const fs = require('fs');
const myArgs = process.argv.slice(2);
// Load the lunr.js library at runtime.
const lunr = require(myArgs[0]);
const documents = require(myArgs[1]);
const output = myArgs[2];

var idx = lunr(function () {
  this.ref('id');
  this.field('t');
  this.field('b');
  this.field('k');
  documents.forEach(function (doc) {
    this.add(doc);
  }, this);
});

fs.writeFileSync(output, JSON.stringify(idx));
