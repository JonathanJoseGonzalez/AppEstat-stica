# app.rb

require_relative 'estatistica/base_estatistica'
require_relative 'estatistica/calculo_factory'

class EstatisticaApp
  def iniciar
    puts "Iniciando o programa de estatísticas..."
    estatistica = EstatisticaBase.new

    loop do
      puts "Insira os dados (separados por espaço):"
      dados = gets.chomp.split.map(&:to_f)
      puts "Insira as frequências correspondentes (separadas por espaço):"
      frequencias = gets.chomp.split.map(&:to_i)

      estatistica.dados = dados
      estatistica.frequencias = frequencias

      estatistica.calcular_estatisticas_basicas

      puts "Dados: #{estatistica.dados}, Frequências: #{estatistica.frequencias}"
      puts "Média: #{estatistica.media}"
      puts "Variância: #{estatistica.variancia.round(2)}"
      puts "Desvio Padrão: #{estatistica.desvio_padrao.round(2)}"
      puts "Coeficiente de Variação: #{estatistica.coeficiente_variacao.round(2)}%"

      puts "\nDeseja realizar um cálculo adicional?"
      puts "1. Agrupamento em Classes"
      puts "2. Agrupamento Discreto"
      puts "3. Distribuição Normal para um valor específico"
      puts "4. Distribuição Exponencial"
      puts "5. Distribuição Binomial"
      puts "6. Distribuição Uniforme"
      puts "7. Distribuição de Poisson"
      puts "8. Regressão Linear e Coeficiente de Determinação"
      puts "9. Sair"
      opcao = gets.chomp.to_i

      CalculoFactory.realizar_calculo(opcao, estatistica)
      puts "\nDeseja realizar outro cálculo? (s/n)"
      continuar = gets.chomp.downcase
      break if continuar != 's'
    end
  end
end

app = EstatisticaApp.new
app.iniciar
