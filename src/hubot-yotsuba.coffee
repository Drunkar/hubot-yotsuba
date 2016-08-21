# Description:
#   Yotsubato! image reply from gazoreply.jp.
#
# Dependencies:
#   cheerio-httpcli
#
# Configuration:
#   None
#
# Commands:
#   hubot yotsuba|よつば
#
# Author:
#   Drunkar <drunkars.p@gmail.com>
#

cheerio = require('cheerio-httpcli')

module.exports = (robot) ->

    robot.respond /(yotsuba|よつば)/i, (msg) ->
        console.log "fetching..."
        cheerio.fetch "http://gazoreply.jp/tag/74/", {}, (err, $, res) ->
            console.log "done"
            if err
                message = "エラーっぽい"
            else
                image_urls = []
                $("#photo-list img").map (d,i) ->
                    image_urls.push i.attribs.src
                randnum = Math.floor( Math.random() * image_urls.length)
                message = image_urls[randnum]

            msg.send message