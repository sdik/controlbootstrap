module TransferenciasHelper
    def sort_linkT(column:, label:)
        # Mescla os parâmetros de filtro atuais com os parâmetros de ordenação
        link_params = request.query_parameters.merge({ column: column, direction: next_direction(column) })
      
        # Gera o link com os parâmetros mesclados
        link_to(label, transferencias_path(link_params))
      end
     
    def items_per_page_formT(current_params)
        form_with(url: transferencias_path, method: :get, local: true) do |form|
          current_params.each do |key, value|
            concat form.hidden_field key, value: value unless key == 'items_per_page'
          end
          concat form.label :items_per_page, 'Itens por página:'
          concat form.select :items_per_page, options_for_select([10, 20, 30, 50, 100, Transferencia.count], current_params[:items_per_page].to_i), {}, onchange: 'this.form.submit();'
        end
      end
end
