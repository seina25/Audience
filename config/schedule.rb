
# 設定===================================================

# wheneverの読込時にrailsを起動するためrootパス取得
require File.expand_path(File.dirname(__FILE__) + '/environment')

# 出力先のログファイルの指定（エラー内容）
set :output, 'log/cron.log'

# ジョブの実行環境の指定（環境で切り替える）
# 開発環境(本番環境行ったらOFFにする)
# rails_env = Rails.env.to_sym
# set :environment, rails_env

# 本番環境
rails_env = ENV['RAILS_ENV'] ||= 'production'
set :environment, rails_env
ENV.each { |k, v| env(k, v) }

# =======================================================

# UTCの時間なので-9hにする

# 実際にやる予定==========================================

# 毎日 日本時間 01:00のスケジューリング(5日後のデータ取得)
every 1.day, at: '16:00 pm' do
  runner 'Batch::FivedayslaterUpdate.fivedayslater_update'
rescue StandardError => e
  Rails.logger.error('aborted rails runner')
  raise e
end

# 毎日 日本時間 03:00のスケジューリング（3日後のデータ取得）
every 1.day, at: '18:00 pm' do
  runner 'Batch::ThreedayslaterUpdate.threedayslater_update'
rescue StandardError => e
  Rails.logger.error('aborted rails runner')
  raise e
end

# ========================================================

