class Batch::FivedayslaterUpdate
require 'selenium-webdriver'

  # 5日後のデータ取得
  def self.fivedayslater_update
    puts 'start'
    puts '5dayslater_data'
    puts DateTime.now

    @wait_time = 3
    @timeout = 5

    # Seleniumの初期化
    Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
    Selenium::WebDriver.logger.level = :warn

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.manage.timeouts.implicit_wait = @timeout

    search_date =  (Date.today + 5).strftime('%Y-%m-%d')

    # 番組表のページを開く
    driver.navigate.to("https://tv.yahoo.co.jp/search?t=3&g=&d=" + search_date + "&ob=&oc=%2B3000&dts=0&dtse=0&q=&a=&s=00")

    # 検索結果数
    sum = driver.find_element(:class, 'searchResultHeaderSumResultNumber').text.to_i
    puts sum

    # ページ数分ループ
    (0..((sum/10)+1)).each do |page|
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      driver = Selenium::WebDriver.for :chrome, options: options
      driver.manage.timeouts.implicit_wait = @timeout

      # 該当の日時とページ数を代入しページを開く
      driver.navigate.to("https://tv.yahoo.co.jp/search?t=3&g=&d=" + search_date + "&ob=&oc=%2B3000&dts=0&dtse=0&q=&a=&s=" + page.to_s + "0")

      @programs = []
      elements = driver.find_elements(:class, 'programListItemTitleLink')
      @urls = elements.map { |element| element.attribute('href') }
      @urls.first(1).each do |url|
        driver.navigate.to(url)

        sleep(rand(5))
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
        talent = driver.find_element(:xpath, "//h3[contains(text(), '出演者')]/following-sibling::p[1]").text
        rescue Selenium::WebDriver::Error::NoSuchElementError
        talent = "※ 情報がありません"
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

        # 取得元のdatetimeの表記が12h制なのでdateとtimeを分けて取得　dateは属性値からdate情報のみ抽出、timeはtextから取得
        # start_datetime
        begin
        start_date = driver.find_element(:xpath, "//p[contains(text(), '放送日時・内容')]/following-sibling::div[1]/time[1]").attribute("datetime").slice(0..9)
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
        end_date = driver.find_element(:xpath, "//p[contains(text(), '放送日時・内容')]/following-sibling::div[1]/time[2]").attribute("datetime").slice(0..9)
        rescue Selenium::WebDriver::Error::NoSuchElementError
        end_date = ""
        end

        begin
        end_time = driver.find_element(:class, "scheduleTextTimeEnd").text
        rescue Selenium::WebDriver::Error::NoSuchElementError
        end_time = ""
        end

        sleep(rand(5))

        # 取得したdate、timeを結合、タイムゾーンをJSTに変更
        # 放送開始時間
        year, month, day = start_date.split('-').map(&:to_i)
        hour, minute = start_time.split(':').map(&:to_i)
        start_datetime = Time.zone.local(year, month, day, hour, minute)
        # 放送終了時間
        year, month, day = end_date.split('-').map(&:to_i)
        hour, minute = end_time.split(':').map(&:to_i)
        end_datetime = Time.zone.local(year, month, day, hour, minute)

        # 曜日取得
        by_weekday = start_datetime.wday

        # データを＠programsに格納
        @programs.push( 'title': title, 'second_title': second_title, 'talent': talent, 'channel': channel, 'category': category,
        'start_datetime': start_datetime, 'end_datetime': end_datetime, 'by_weekday': by_weekday )

        puts 'push'
      end

      # ドライバーを閉じる
      driver.quit

      # データをデータベースに保存
      @programs.each do |program|
        @program = Program.find_or_initialize_by(channel: program[:channel], start_datetime: program[:start_datetime] )
        if @program.new_record?
        Program.create(program)
        else
        @program.update_columns(program)
        end
        STDOUT.flush
      end
    end
    puts 'Finish'
  end
end