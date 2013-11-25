class AddAttrs1ToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :timeOfRunning, :integer
    add_column :repairs, :dayOfTest, :date
    add_column :repairs, :arrivalComment, :text
    add_column :repairs, :orderNo, :string
    add_column :repairs, :orderDate, :date
    add_column :repairs, :constructionNo, :string
    add_column :repairs, :desirableFinishDate, :date
    add_column :repairs, :estimatedFinishDate, :date
  end
end
