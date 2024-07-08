module ApplicationHelper
    def sortable(column, title = nil)
        title ||= column.titleize
        direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
        link_to title, sort: column, direction: direction, nome: params[:nome], cidade: params[:cidade]
    end
end
