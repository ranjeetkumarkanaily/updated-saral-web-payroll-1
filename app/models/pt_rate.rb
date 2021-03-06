class PtRate < ActiveRecord::Base
  attr_accessible :pt_group_id, :paymonth_id,:min_sal_range,:max_sal_range,:pt
  acts_as_audited

  belongs_to :pt_group
  belongs_to :paymonth

  delegate :name, :to => :pt_group, :prefix => true
  delegate :month_name, :to => :paymonth, :prefix => true

  validates_presence_of :pt_group_id, :paymonth_id
  validates_uniqueness_of :min_sal_range, :scope => [:paymonth_id, :pt_group_id]

  def get_max_sal_range
    next_row = next_row_on_min_sal_range
    (next_row.min_sal_range.to_f - 0.01) if next_row
  end

  private

    def next_row_on_min_sal_range
      PtRate.where("min_sal_range > ? and paymonth_id = ? and pt_group_id = ?", self.min_sal_range, self.paymonth_id, self.pt_group_id).order("min_sal_range").first
    end

end
