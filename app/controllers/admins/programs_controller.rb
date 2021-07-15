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

    # 警告：割り当てられているが未使用の変数 -wait
    wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)

    # Yahoo番組表を開く
    driver.get('https://tv.yahoo.co.jp/listings')
    sleep(rand(5))

    # 番組表からurl一件ずつ取得
    @programs = []
    elements = driver.find_elements(:class, "listingTablesTextLink")
    @urls = elements.map { |element| element.attribute('href') }
    @urls.first(2).each do |url|
    driver.navigate.to(url)

    sleep(rand(5))

    cur_url = driver.current_url
    p cur_url

    # 番組データを取得
    begin
    title = driver.find_element(:class, "programRatingContentTitle").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    title = ""
    end

    begin
    second_title = driver.find_element(:class, "programVideoContentTitleText").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    second_title = ""
    end

    begin
    cast = driver.find_element(:xpath, "//h3[contains(text(), '出演者')]/following-sibling::p[1]").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    cast = ""
    end

    begin
    channel = driver.find_element(:class, "channelText").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    channel = ""
    end

    begin
    category = driver.find_element(:class, "programOtherDataListText").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    category = ""
    end

    # 日付
    begin
    date = driver.find_element(:xpath, "//p[contains(text(), '放送日時・内容')]/following-sibling::div[1]//span[1]").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    date = ""
    end

    # 開始時間
    begin
    start_time = driver.find_element(:xpath, "//p[contains(text(), '放送日時・内容')]/following-sibling::div[1]//span[3]").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    start_time = ""
    end

    # 終了時間
    begin
    end_time = driver.find_element(:class, "scheduleTextTimeEnd").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    end_time = ""
    end

    # 曜日
    begin
    by_weekday = driver.find_element(:class, "scheduleTextWeek").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    by_weekday = ""
    end

    # save入れる
    p title
    p second_title
    p cast
    p channel
    p category
    p date
    p start_time
    p end_time
    p by_weekday

    @programs.push({ 'title': title, 'second_title': second_title, 'cast': cast, 'channel': channel,
    'category': category, 'date': date, 'start_time': start_time, 'end_time': end_time, 'by_weekday': by_weekday })

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
    end
    # ドライバーを閉じる
    driver.quit

  end

  def spraping
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

