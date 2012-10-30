ActiveAdmin.register Box do
  menu :parent => "Boxes"

form do |f|
    f.inputs do
      f.input :name
      f.input :box_number
    end

    f.inputs "BoxContents" do
      f.has_many :box_contents do |j|
        j.inputs :stock_item, :quantity
      end
    end

    f.buttons
  end

end
