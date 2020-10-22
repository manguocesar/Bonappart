class AddVirtualVisitLinkToApartments < ActiveRecord::Migration[6.0]
  def change
    add_column :apartments, :virtual_visit_link, :string
  end
end
