module PagamentosHelper
    def sort_link(column:, label:)
        # Mescla os parâmetros de filtro atuais com os parâmetros de ordenação
        link_params = request.query_parameters.merge({ column: column, direction: next_direction(column) })
      
        # Gera o link com os parâmetros mesclados
        link_to(label, pagamentos_path(link_params))
      end
      
      def next_direction(column)
        if column == params[:column]
          params[:direction] == 'asc' ? 'desc' : 'asc'
        else
          'asc'
        end
      end
end
