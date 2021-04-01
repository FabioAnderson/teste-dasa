# encoding: utf-8

require "rspec"
require "capybara/cucumber"
require "selenium-webdriver"
require "yaml"
require "pry"
require "base64"
require "httparty"
require "uri"
require "ffaker"
require "date"
require "rubyXL"
require "rest-client"
require "xmlsimple"
require "capybara"
require "net/http"
require "json"
require "erb"

World(Capybara::DSL)

#elementos mapeados
ELEMENTS = YAML.load_file("data/elements.yml")

# configuração de ambientes
if ENV["prod"]
  $url = "http://localhost:8080/"
end

if ENV["chrome"]
  Capybara.default_driver = :chrome
  Capybara.register_driver :chrome do |app|
    caps = Selenium::WebDriver::Remote::Capabilities.chrome
    caps["pageLoadStrategy"] = "none"
    Capybara::Selenium::Driver.new(app, browser: :chrome, port: 9922, desired_capabilities: caps, switches: ["--disable-print-preview", "--disable-web-security", "--reduce-security-for-testing", "--repl", "--incognito", "--disable-dev-shm-usage"])
  end
elsif ENV["chrome_headless"]
  Capybara.default_driver = :chrome_headless
  Capybara.register_driver :chrome_headless do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome, switches: ["--disable-print-preview", "--incognito", "--headless", "disable-gpu", "window-size=1280x720", "--no-sandbox", "--disable-dev-shm-usage"])
  end
elsif ENV["firefox"]
  Capybara.default_driver = :firefox
  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end
elsif ENV["headless_debug"]
  Capybara.default_driver = :poltergeist_debug
  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, inspector: true)
  end
  Capybara.javascript_driver = :poltergeist_debug
elsif ENV["headless"]
  Capybara.javascript_driver = :poltergeist
  Capybara.default_driver = :poltergeist
else
  Capybara.default_driver = :selenium
end

Capybara.default_max_wait_time = 5
