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
YOTSUBA_BASE_URL = "http://gazoreply.jp"

module.exports = (robot) ->

  robot.respond /(yotsuba|よつば)/i, (msg) ->
    console.log "fetching..."
    cheerio.fetch "http://gazoreply.jp/tag/74/", {}, (err, $, res) ->
      console.log "done"
      if err
        message = "エラーっぽい"
      else
        image_urls = []
        $("#photo-list a").map (d,a) ->
          image_urls.push YOTSUBA_BASE_URL + a.attribs.href + "/f.jpg"

        randnum = Math.floor( Math.random() * image_urls.length)
        second_url = image_urls[randnum]
        cheerio.fetch second_url, {}, (err, $, res_second) ->
          if err
            message = "エラーっぽい"
          else
            message = $("#main-image")[0].attr("src")

      console.log "message"
      msg.send message