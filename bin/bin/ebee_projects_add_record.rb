#!/usr/bin/env ruby

# Ugly code warning

require 'faraday'
require 'faraday-cookie_jar'
require 'optparse'
require 'pry'

def require_or_abort(field)
  unless instance_variable_get(field)
    puts "#{field[1..-1]} missing"
    abort
  end
end

OptionParser.new do |opts|
  opts.banner = "Usage: <script> [options]"

  opts.on("-h hours", "--hours=hours", String, "number of worked hours") do |arg|
    @hours = arg
  end

  opts.on("-d date", "--date=date", String, "date") do |arg|
    @date = arg
  end

  opts.on("-p project", "--project=project", String, "project") do |arg|
    @project = arg
  end

  opts.on("-i iteration", "--iteration=iteration", String, "iteration") do |arg|
    @iteration = arg
  end

  opts.on("-w work_type", "--work-type=work_type", String, "work type") do |arg|
    @work_type = arg
  end

  opts.on("-D desc", "--Desc=desc", String, "description") do |arg|
    @description = arg
  end
end.parse!

[:@hours, :@date, :@project, :@iteration, :@work_type, :@description].each do |field|
  require_or_abort field
end

HOST = "http://projects.ebee.cz"

@faraday = Faraday.new(url: HOST) do |faraday|
  faraday.use :cookie_jar
  faraday.request :url_encoded
  #faraday.response :logger
  faraday.adapter Faraday.default_adapter
end

make_me_session = @faraday.get("/login")
login_response = @faraday.post("/process-login",
                               _spring_security_remember_me: "on",
                               j_username: "hlopko@ebee.cz",
                               j_password: "WathfoshforHujShuneurgIk")
redirected_homepage = @faraday.get("/work-records")

work_record_response = @faraday.post("/work-records/new",
           date:  @date,
           project:  30,
           iteration:  310,
           workType:  2,
           workDescription:  @description,
           workedHours:  @hours,
           hoursToBePaid:  @hours)

