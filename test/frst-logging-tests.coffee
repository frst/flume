chai = require "chai"
should = chai.should()
express = require "express"

describe "The frst-logging component", ->

        it "should be required without error", ->
                frstLogging = require "../frst-logging"

        it "should attach to an express server", ->
                frstLogging = require "../frst-logging"
                server = express()
                frstLogging(server, {env: "production"})

        it "should override default console.log behavior", ->
                frstLogging = require "../frst-logging"
                server = express()
                frstLogging(server, {env: "production"})
                console.log "test logging"