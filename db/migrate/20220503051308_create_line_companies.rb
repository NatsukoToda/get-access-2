class CreateLineCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :line_companies, id: false do |t|
      t.integer   :code, null: false, comment: "路線を運営する事業者コード"
      t.string    :name, null: false, comment: "路線を運営する事業者名"
      t.string    :name_omit, null: false, comment: "事業者名の略称"
      t.integer   :close_flag, comment: "閉業フラグ"       
      t.timestamps null: true   
      t.timestamps
    end
    execute "ALTER TABLE line_companies ADD PRIMARY KEY (code);"
  end
end
