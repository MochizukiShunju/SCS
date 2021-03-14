module ItemsHelper
 def sort_order(column, title)
  direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
  link_to title, { sort: column, direction: direction }
 end

 def converting_to_jpy(price)
    "#{price.to_s(:delimited, delimiter: ',')}円"
 end
end
