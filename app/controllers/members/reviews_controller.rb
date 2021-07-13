class Members::ReviewsController < ApplicationController
  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

def index

    @wait_time = 3
    @timeout = 4

    # Seleniumの初期化
    # class ref: https://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Chrome
    Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
    Selenium::WebDriver.logger.level = :warn

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.manage.timeouts.implicit_wait = @timeout
    wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)

    # Yahoo番組表を開く
    driver.get('https://tv.yahoo.co.jp/listings')
    sleep 2

    # 番組表からurl取得
    # begin
    elements = driver.find_element(:class, "listingTablesTextLink")
    # @titles= []
    # @title.each do |element|
    @element = elements.attribute('href')