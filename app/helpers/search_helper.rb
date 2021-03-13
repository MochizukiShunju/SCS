module SearchHelper
  def sort_order_for_search(column, title)
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { search: { model: params['search']['model'], content: params['search']['content'], how: params['search']['how'] }, sort: column, direction: direction }
  end
end