#!/usr/bin/env ruby

#ugly code warning

require 'rubygems'
require 'faraday'
require 'faraday-cookie_jar'
require 'optparse'
require 'pry'

OptionParser.new do |opts|
  opts.banner = "Usage: <script> [options]"

  opts.on("-h hours",
          "--hours=hours",
          Integer,
          "number of worked hours") do |arg|
            @hours = arg
  end

  opts.on("-d date",
          "--date=date",
          String,
          "date") do |arg|
            @date = arg
  end

  opts.on("-D desc",
          "--Desc=desc",
          String,
          "description") do |arg|
            @description = arg
  end
end.parse!



HOST = "http://projects.ebee.cz"

@faraday = Faraday.new(url: HOST) do |faraday|
  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
  faraday.use :cookie_jar
end

get_response = @faraday.get("/process-login")
get2_response = @faraday.get(get_response.headers["location"])

login_response = @faraday.post("/process-login",
           j_username: "hlopko@ebee.cz",
           j_password: "WathfoshforHujShuneurgIk")

work_record_response = @faraday.post("/work-records/new",
           date:  @date,
           project:  30,
           iteration:  310,
           workType:  2,
           workDescription:  @description,
           workedHours:  @hours,
           hoursToBePaid:  @hours)


