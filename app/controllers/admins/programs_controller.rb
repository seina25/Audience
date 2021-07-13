class Admins::ProgramsController < ApplicationController
  require 'selenium-webdriver'
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
    begin
    elements = driver.find_elements(:class, "listingTablesTextLink")
    @urls = elements.map { |element| element.attribute('href') }
    @urls.first(3).each do |url|
      p url
    driver.navigate.to(url)
    # d = Selenium::WebDriver.for :chrome, options: options
    # d.manage.timeouts.implicit_wait = @timeout
    # wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)

    sleep 2

    cur_url = driver.current_url
    p cur_url

    # 番組データを取得
    #binding.pry
    title = driver.find_element(:class, "programRatingContentTitle").text
    cast = driver.find_element(:class, "programCastInformationList").text
    date = driver.find_element(:class, "schedule").text
    channel = driver.find_element(:class, "channelText").text
    #binding.pry
    p title
    p cast
    p date
    p channel

    @programs = title + cast + date + channel
    p @program
    rescue Selenium::WebDriver::Error::NoSuchElementError
    p 'no such element error!!'

    end

    # 番組名を取得
    # @title = driver.find_elements(:class, "programListItemTitleLink")
    # @description = driver.find_element(:class, "programListItemDescription").text
    # @date = driver.find_element(:class, "schedule").text
    # @channel = driver.find_element(:class, "channel").text
    # @titles = []
    # @title.each do |title|
    # @titles.push(title.text)
    # end

    # データをデータベースに保存
    # for i in 0..@titles.count
    # program = Program.new
    # program.title = @titles[i]
    # program.date = @dates[i]
    # program.save

    # ドライバーを閉じる
    driver.quit
    end
  end

  def new
    @program = Program.new
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

