class Admins::ProgramsController < ApplicationController
  require 'selenium-webdriver'
  def new
    @program = Program.new
  end

  def index
    #@keyword = Program.new

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
      search_box = driver.find_element(:id, 'ariaID-Search__inputText-header').send_keys "" # 検索欄
      search_btn = driver.find_element(:class, 'headerSearchWindowButton').click # 検索ボタン
      p search_box
      p search_btn
      #@titles = driver.find_element().text
      #@titles.each do |title|
      #title.find_element(:class, "programListItem").text
      #end

    rescue Selenium::WebDriver::Error::NoSuchElementError
      p 'no such element error!!'
    return
    end

    # 入力欄に''を入力し、検索ボタンを押下
    #search_box.send_keys 'aws'
    #search_btn.click
    # 検索結果の最初の一件を取得
    #search = driver.find_element(:class, "programListItem")
    #search.click
    #p search
    # 番組名を取得
    @title = driver.find_element(:class, "programListItemTitleLink").text
    @description = driver.find_element(:class, "programListItemDescription").text
    @date = driver.find_element(:class, "schedule").text
    @channel = driver.find_element(:class, "channel").text

    #p content

    # ドライバーを閉じる
    driver.quit
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end
end

