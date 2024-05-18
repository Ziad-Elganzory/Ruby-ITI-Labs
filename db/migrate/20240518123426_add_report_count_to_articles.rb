class AddReportCountToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column(:articles, :report_count, :integer, default: 0)
  end
end
