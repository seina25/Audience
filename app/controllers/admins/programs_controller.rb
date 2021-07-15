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

    # 番組表からurl取得
    begin
    @programs = []
    elements = driver.find_elements(:class, "listingTablesTextLink")
    @urls = elements.map { |element| element.attribute('href') }
    @urls.first(2).each do |url|
      p url
    driver.navigate.to(url)
    # d = Selenium::WebDriver.for :chrome, options: options
    # d.manage.timeouts.implicit_wait = @timeout
    # wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)

    sleep(rand(5))

    cur_url = driver.current_url
    p cur_url

    # 番組データを取得
    title = driver.find_element(:class, "programRatingContentTitle").text
    second_title = driver.find_element(:class, "programVideoContentTitleText").text
    cast1 = driver.find_element(:xpath, "//*[@id='__next']/div/main/article/div/div[7]/div[2]/section[3]/p").text
    cast2 = driver.find_element(:xpath, "//*[@id='__next']/div/main/article/div/div[7]/div[2]/section[2]/p").text
    cast3 = driver.find_element(:class, "programCastInformationList").text
    channel = driver.find_element(:class, "channelText").text
    category = driver.find_element(:class, "programOtherDataListText").text
    # 日付
    date = driver.find_element(:xpath, "//*[@id='__next']/div/main/article/div/div[6]/div/div/div/time[1]/span[1]").text
    # 開始時間
    start_time = driver.find_element(:xpath, "//*[@id='__next']/div/main/article/div/div[6]/div/div/div/time[1]/span[3]").text
    # 終了時間
    end_time = driver.find_element(:class, "scheduleTextTimeEnd").text
    # 曜日
    by_weekday = driver.find_element(:class, "scheduleTextWeek").text

    # save入れる
    p title
    p second_title
    p cast1
    p cast2
    p cast3
    p channel
    p category
    p date
    p start_time
    p end_time
    p by_weekday

    @programs.push({ 'title': title, 'second_title': second_title, 'cast1': cast1, 'cast2': cast2, 'cast3': cast3,
    'channel': channel, 'category': category, 'date': date, 'start_time': start_time, 'end_time': end_time, 'by_weekday': by_weekday, })

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

