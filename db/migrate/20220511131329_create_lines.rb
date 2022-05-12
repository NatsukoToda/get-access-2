class CreateLines < ActiveRecord::Migration[5.2]
  def change
    create_table :lines, id: false do |t|
      t.integer   :code, null: false, primary_key: true, comment: "路線コード"
      t.string    :name, null: false, comment: "路線名"
      t.string    :name_omit, null: false, comment: "路線の略称"
      t.integer   :line_company_code, comment: "路線の運営事業者コード"
      t.integer   :close_flag, comment: "閉業フラグ"       
      t.timestamps null: true   
      t.timestamps
    end
  end
end