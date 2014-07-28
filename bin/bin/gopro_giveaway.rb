#!/usr/bin/env ruby

#ugly code warning

require 'rubygems'
require 'mechanize'
require 'highline/import'
require 'pry'

HOST = "http://gopro.com/daily-giveaway/"

def fill_in_captcha(agent, page, form)
  iframe_url = page.iframes[1].src
  params = iframe_url.split("?").last
  captcha_iframe = agent.click(page.iframes[1])
  captcha_form = captcha_iframe.forms.first
  captcha_image = captcha_iframe.parser.css("img").first["src"]
  # open browser with captcha image
  system("gnome-open", "http://api.recaptcha.net/#{captcha_image}")
  # enter captcha response in terminal
  captcha_says = ask("Enter Captcha from Browser Image: ") { |q| q.echo = true }
  captcha_form["recaptcha_response_field"] = captcha_says
  # submit captcha
  captcha_form.action= "http://www.google.com/recaptcha/api/noscript?#{params}"
  captcha_response = captcha_form.submit
  # grab secret
  captcha_response_div = captcha_response.parser.css("textarea").first
  captcha_response = captcha_response_div.text if captcha_response_div

  # submit title, description, tags, categories, and captcha
  form["recaptcha_challenge_field"] = captcha_response
  form["recaptcha_response_field"] = captcha_says
end

def submit_form(data)
  agent = Mechanize.new
  page = agent.get(HOST)
  form = page.form_with(id: "main_form")
  form['firstName'] = data[:first_name]
  form['lastName'] = data[:last_name]
  form['email'] = data[:email]
  form['zip'] = data[:postal_code]
  form['country'] = data[:country]
  fill_in_captcha(agent, page, form)
  form.submit.body
end

datasets = [{
	first_name:  "Marcel",
  last_name: "Hlopko",
  email: "hlopik@gmail.com",
  postal_code: "17000",
  country: "_czechRepublic"
}, {
	first_name:  "Marcel",
  last_name: "Hlopko",
  email: "marcel.hlopko@gmail.com",
  postal_code: "17000",
  country: "_czechRepublic"
}, {
	first_name:  "Marcel",
  last_name: "Hlopko",
  email: "marcel.hlopko@fit.cvut.com",
  postal_code: "17000",
  country: "_czechRepublic"
}, {
	first_name:  "Marcel",
  last_name: "Hlopko",
  email: "hlopko@ebee.cz",
  postal_code: "17000",
  country: "_czechRepublic"
}, {
	first_name:  "Lucia",
  last_name: "Hlopkova",
  email: "lucia.hlopkova@gmail.com",
  postal_code: "17000",
  country: "_czechRepublic"
}, {
	first_name:  "Pavlina",
  last_name: "Michalkova",
  email: "michalkova.pavlina@centrum.sk",
  postal_code: "17000",
  country: "_czechRepublic"
}, {
	first_name:  "Pavlina",
  last_name: "Michalkova",
  email: "pavlina.michalkova@gmail.com",
  postal_code: "17000",
  country: "_czechRepublic"
}
]


datasets.each do |data|
  result = submit_form data
  unless result.include? "Entry Has Been Received"
    puts "wrong captcha"
    result = submit_form data
  end
  puts "OK"
end

