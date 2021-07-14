class Members::SearchesController < ApplicationController
  require 'selenium-webdriver'
  def search
    @keyword = params[:search]

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

    # Yahooを開く
    driver.get('https://tv.yahoo.co.jp/')
    # ちゃんと開けているか確認するため、sleepを入れる
    sleep 2

    begin
      search_box = driver.find_element(:id, 'ariaID-Search__inputText-header').send_keys @keyword # 検索欄
      search_btn = driver.find_element(:class, 'headerSearchWindowButton').click # 検索ボタン
      p search_box
      p search_btn

    rescue Selenium::WebDriver::Error::NoSuchElementError
      p 'no such element error!!'
    return
    end

    driver.find_elements(:class,"innerMain").each do |i|
      begin
        @title = i.find_element(:class, "programListItemTitleLink").text
        @description = i.find_element(:class, "programListItemDescription").text
        @date = i.find_element(:class, "schedule").text
        @channel = i.find_element(:class, "channel").text
      rescue Selenium::WebDriver::Error::NoSuchElementError
        p 'no such element error!!'
      return
      end
    end

    # ドライバーを閉じる
    driver.quit
  end
end
