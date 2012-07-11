{models} = require "frst-mongoose"
util = require "util"

debug = false

module.exports = (env)->

        # redirect log out put to disk
        if env == "production"
                console.log = ()->
                        log = new models.Log()
                        data = arguments
                        log.data = util.inspect(data, false, 5) unless typeof data == 'string'
                        log.save()

                # log all server errors
                process.on 'uncaughtException', (error)->
                        console.log("Uncaught exception:\n" + error.message + "\n" + error.stack)
                        process.exit(0)
        else if debug
                console.log = ()->
                        log = new models.Log()
                        data = arguments
                        log.data = util.inspect(data, false, 5) unless typeof data == 'string'
                        log.save()
                console.log('application logging')