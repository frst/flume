chai = require "chai"
should = chai.should()
express = require "express"

describe "The flume logging component", ->

        it "should be required without error", ->
                frstLogging = require "../flume"

        it "should attach to an express server", ->
                frstLogging = require "../flume"
                server = express()
                frstLogging(server, {env: "production"})

        it "should override default console.log behavior", ->
                frstLogging = require "../flume"
                server = express()
                frstLogging(server, {env: "production"})
                console.log "test logging"

        it "shouldn't require any parameters", ->
                frstLogging = require "../flume"
                frstLogging()
                console.log "no parameters logging"

        it "should fail gracefully", ->
                frstLogging = require "../flume"
                frstLogging()

                # logging a circular obj
                obj = {}
                obj.sub = obj
                console.log obj
