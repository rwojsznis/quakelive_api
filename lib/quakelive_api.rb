require "quakelive_api/version"
require "quakelive_api/base"
require "quakelive_api/award"
require "quakelive_api/game_time"
require "quakelive_api/favourite"
require "quakelive_api/recent_game"
require "quakelive_api/competitor"
require "quakelive_api/model"
require "quakelive_api/parser/base"
require "quakelive_api/parser/summary"
require "quakelive_api/parser/statistics"
require "quakelive_api/profile"
require "quakelive_api/profile/statistics"
require "quakelive_api/profile/summary"
require "quakelive_api/error/player_not_found"
require "quakelive_api/error/request_error"
require "net/http"
require "nokogiri"
require "date"

module QuakeliveApi

  def self.site
    "http://www.quakelive.com"
  end

end
