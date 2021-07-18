require 'selenium-webdriver'

module ProgramScrapesConcern

extend ActiveSupport::Concern
  def set_program_site
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
    sleep(rand(5))
    driver.get('https://tv.yahoo.co.jp/listings')

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

    # start_datetime
    begin
    start_date = driver.find_element(:xpath, "//p[contains(text(), '放送日時・内容')]/following-sibling::div[1]/time[1]").attribute("datetime").to_datetime.strftime("%Y-%m-%d")
    rescue Selenium::WebDriver::Error::NoSuchElementError
    start_date = ""
    end

    begin
    start_time = driver.find_element(:xpath, "//p[contains(text(), '放送日時・内容')]/following-sibling::div[1]//span[3]").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    start_time = ""
    end

    # end_datetime
    begin
    end_date = driver.find_element(:xpath, "//p[contains(text(), '放送日時・内容')]/following-sibling::div[1]/time[2]").attribute("datetime").to_datetime.strftime("%Y-%m-%d")
    rescue Selenium::WebDriver::Error::NoSuchElementError
    end_date = ""
    end

    begin
    end_time = driver.find_element(:class, "scheduleTextTimeEnd").text
    rescue Selenium::WebDriver::Error::NoSuchElementError
    end_time = ""
    end

    p title
    p second_title
    p cast
    p channel
    p category
    p start_date
    p start_time
    p end_date
    p end_time

    # 取得したdatetimeデータが12h表記なので文字列で24h表記に修正後datetimeに戻す
    start_datetime_string = start_date + " " + start_time
    start_datetime = start_datetime_string.to_datetime

    end_datetime_string = end_date + " " + end_time
    end_datetime = end_datetime_string.to_datetime

    # save入れる
    @programs.push({ 'title': title, 'second_title': second_title, 'cast': cast, 'channel': channel,
    'category': category, 'start_datetime': start_datetime, 'end_datetime': end_datetime })

    p @programs
    # データをデータベースに保存
    # for i in 0..@titles.count
    # program = Program.new
    # program.title = @titles[i]
    # program.date = @dates[i]
    # program.save
    end
    # ドライバーを閉じる
    driver.quit

    # 開始時刻
    # 時間
    # hour = datetime.hour
    # # 分
    # minute = datetime.minute

    # # 日付
    # year = datetime.year
    # month = datetime.month
    # date = datetime.day

    # # 曜日 （0：日 〜 6：土）
    # by_weekday = datetime.wday
  end
end