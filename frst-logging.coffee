util = require "util"
express = require "express"
fs = require "fs"

debug = false

module.exports = (server, options)->

        throw new Error("frst-logging must be instantiated with an express server") unless server
        throw new Error("frst-logging must be instantiated with an environment option") unless options.env

        env = options.env

        # access log & redirect stdout to disk
        if env == "production" or debug

                logger_options =
                        format: ':remote-addr - - [:date] ":method :url HTTP/:http-version" :status :res[content-length] ":referrer" ":user-agent" :response-time',
                        buffer:true,
                        stream: fs.createWriteStream('logs/access.log', {flags: 'a'})

                server.use(express.logger(logger_options))

                errorStream = fs.createWriteStream('logs/production.log', {flags: 'a'})

                console.log = ()->
                        data = util.inspect(arguments, false, 5) unless typeof arguments == 'string'
                        errorStream.write data

                # log all server errors
                process.on 'uncaughtException', (error)->
                        console.log("Uncaught exception:\n" + error.message + "\n" + error.stack)
                        process.exit(0)
