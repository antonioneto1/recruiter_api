class AddContentTypeToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :content_type, :string
  end
end
