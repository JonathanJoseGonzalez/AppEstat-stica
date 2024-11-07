class CalculoFactory
  def self.realizar_calculo(opcao, estatistica, **params)
    case opcao
    when 1
      estatistica.calcular_agrupamento_em_classes(params[:num_classes])
    # Outros casos de cálculo aqui
    else
      "Cálculo não implementado para a opção #{opcao}"
    end
  end
end
