# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever



# 設定===================================================



# wheneverの読込時にrailsを起動するためrootパス取得
require File.expand_path(File.dirname(__FILE__) + "/environment")

# 出力先のログファイルの指定（エラー内容）
set :output, 'log/cron.log'

# ジョブの実行環境の指定（環境で切り替える）
# 開発環境(本番環境行ったらOFFにする)
# rails_env = Rails.env.to_sym
# set :environment, rails_env


# 本番環境
# set :environment, :production
rails_env = ENV['RAILS_ENV'] ||= 'production'
set :environment, rails_env
ENV.each { |k, v| env(k, v) }


# =======================================================

# UTCの時間なので-9hにする

# テスト用===============================================

# 毎日 日本時間am01:25のスケジューリング

# every 1.minute do
#   begin
#     runner 'Batch::Test.test'
#   rescue => e
#     Rails.logger.error("aborted rails runner")
#     raise e
#   end
# end

# 毎日 日本時間 01:00のスケジューリング
every 1.day, at: '16:45 pm' do
  begin
    runner 'Batch::FivedayslaterUpdate.fivedayslater_update'
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

# 毎日 日本時間 03:00のスケジューリング
every 1.day, at: '09:30 am' do
  begin
    runner 'Batch::ThreedayslaterUpdate.threedayslater_update'
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end



# ========================================================



# 実際にやる予定==========================================

# 毎日 am0:00とpm12:00のスケジューリング

# every 1.day,  at: ['0:00 am', '12:00 pm'] do
#   begin
#     runner 'Batch::DataUpdate.set_scrape'
#   rescue => e
#     Rails.logger.error("aborted rails runner")
#     raise e
#   end
# end

# 毎日 am1:30とam3:00のスケジューリング
# every 30.minute do
#   begin
#     runner 'Batch::DataUpdate.threedays_later'
#   rescue => e
#     Rails.logger.error("aborted rails runner")
#     raise e
#   end
# end


# # 毎日 am2:30とam4:00のスケジューリング
# every 1.day,  at: ['2:30 am', '4:00 am'] do
#   begin
#     runner 'Batch::DataUpdate.fivedays_later'
#   rescue => e
#     Rails.logger.error("aborted rails runner")
#     raise e
#   end
# end
# ========================================================




