util = require "util"
express = require "express"
fs = require "fs"

debug = false

begin_logging = (server, logs_dir)->

        logger_options =
                format: ':remote-addr - - [:date] ":method :url HTTP/:http-version" :status :res[content-length] ":referrer" ":user-agent" :response-time',
                buffer:true,
                stream: fs.createWriteStream("#{logs_dir}/access.log", {flags: 'a'})

        server.use(express.logger(logger_options))

        logStream = fs.createWriteStream("#{logs_dir}/production.log", {flags: 'a'})

        console.log = ()->
                data = JSON.stringify(arguments)
                now = new Date()
                logStream.write "[#{now.toISOString()}] #{data}\n"

        # log all server errors
        process.on 'uncaughtException', (error)->
                console.log("Uncaught exception:\n" + error.message + "\n" + error.stack)
                process.exit(0)

module.exports = (server, options)->

        throw new Error("frst-logging must be instantiated with an express server") unless server
        throw new Error("frst-logging must be instantiated with an environment option") unless options.env

        env = options.env

        # access log & redirect stdout to disk
        if env == "production" or debug

                # Create logs directory if it doesn't yet exists
                logs_dir = "#{__dirname}/logs"
                fs.stat logs_dir, (err)->
                        if err
                                fs.mkdir logs_dir, 0o0777, (err)-> begin_logging(server, logs_dir)
                        else
                                begin_logging(server, logs_dir)
