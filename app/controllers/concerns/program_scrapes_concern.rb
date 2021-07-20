require 'selenium-webdriver'

module ProgramScrapesConcern

extend ActiveSupport::Concern


  def today_scrape
    @wait_time = 3
    @timeout = 5

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
    @urls.first(3).each do |url|
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
    cast = "※ 情報がありません"
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


    @programs.push( 'title': title, 'second_title': second_title, 'cast': cast, 'channel': channel, 'category': category,
    'start_datetime': start_datetime, 'end_datetime': end_datetime, 'by_weekday': by_weekday )
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
    end

  end

  # ====================================================================================================================


  def weekend_scrape

    @wait_time = 3
    @timeout = 5

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

    # Yahoo番組表の検索画面を開く
    driver.get('https://tv.yahoo.co.jp/search')

    # 検索オプションを開く
    driver.find_element(:class, 'searchOption').click

    # BS項目除くためチェック入れる
    driver.find_element(:id, 'Check-02').click

    # 日付を選択
    driver.find_element(:xpath, '//*[@id="__next"]/div/main/div[1]/article/div[2]/form[2]/div/div/div[2]/div[1]/div[2]/div/label/select').click
    driver.find_element(:xpath, '//*[@id="__next"]/div/main/div[1]/article/div[2]/form[2]/div/div/div[2]/div[1]/div[2]/div/label/select/option[2]').click

    # 放送時間（30分以上を選択）
    driver.find_element(:xpath, '//*[@id="__next"]/div/main/div[1]/article/div[2]/form[2]/div/div/div[2]/div[2]/div[1]/div/label/select').click
    driver.find_element(:xpath, '//*[@id="__next"]/div/main/div[1]/article/div[2]/form[2]/div/div/div[2]/div[2]/div[1]/div/label/select/option[3]').click

    # 検索ボタン
    driver.find_element(:class, 'searchOptionSearchButton').click

    #検索結果画面
    current_url = driver.current_url
    p current_url

    # 検索結果数
    sum = driver.find_element(:class, 'searchResultHeaderSumBox').text
    p sum


    # タイトルからurl一件ずつ取得
    2.times  do
    @programs = []
      elements = driver.find_elements(:class, 'programListItemTitleLink')
      @urls = elements.map { |element| element.attribute('href') }
      @urls.first(11).each do |url|
      driver.navigate.to(url)

      # # 8日後の番組表に遷移
      # weekend_elements = driver.find_element(:xpath, "//*[@id='__next']/div/div[1]/div[1]/div[2]/div[2]/div/div[1]/div[2]/ul/li[8]/h2/a")
      # weekend_url = weekend_elements.attribute('href')
      # driver.navigate.to(weekend_url)


      # 番組表からurl一件ずつ取得
      # @programs = []
      # elements = driver.find_elements(:class, "listingTablesTextLink")
      # @urls = elements.map { |element| element.attribute('href') }
      # @urls.first(2).each do |url|
      # driver.navigate.to(url)

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
      cast = "※ 情報がありません"
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


      @programs.push( 'title': title, 'second_title': second_title, 'cast': cast, 'channel': channel, 'category': category,
      'start_datetime': start_datetime, 'end_datetime': end_datetime, 'by_weekday': by_weekday )
      driver.navigate.back
      end

      #次のページに進む

      cur_url = driver.current_url
      p cur_url

        next_url = driver.find_element(:xpath, '//*[@id="__next"]/div/main/div[1]/article/div[2]/div[1]/div[1]/span[2]/a')
       if next_url.displayed?
        driver.find_element(:xpath, '//*[@id="__next"]/div/main/div[1]/article/div[2]/div[1]/div[1]/span[2]/a').click

        cur_url = driver.current_url
        p cur_url
       else
         break
       end
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
    end

  end


end