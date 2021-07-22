class ProgramNotification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
  belongs_to :program, optional: true
  belongs_to :favorite, optional: true

  belongs_to :member, optional: true
  belongs_to :admin, optional: true

#  today = Time.zone.now
#    @onair_day = Program.where(start_datetime: 'today')
#    @member = Member.find(params[:id])
#    @program = Member.favorite.program
  def self.today_favorite_program(member)
    member.program_notifications.includes(:program).where(programs: { start_datetime: Time.zone.now.all_day })
  end

end
