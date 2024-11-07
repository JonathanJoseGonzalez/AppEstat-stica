class EstatisticaBase
  attr_accessor :dados, :frequencias, :media, :variancia, :desvio_padrao, :coeficiente_variacao

  def initialize
    @dados = []
    @frequencias = []
    @media = 0.0
    @variancia = 0.0
    @desvio_padrao = 0.0
    @coeficiente_variacao = 0.0
  end

  # Método para calcular a média ponderada
  def calcular_media
    total_frequencia = @frequencias.sum
    return 0 if total_frequencia.zero?

    soma_ponderada = @dados.zip(@frequencias).map { |d, f| d * f }.sum
    @media = soma_ponderada / total_frequencia
  end

  # Método para calcular a variância
  def calcular_variancia
    return 0 if @frequencias.sum.zero?

    media_quadrado = @dados.zip(@frequencias).map { |d, f| f * (d - @media) ** 2 }.sum
    @variancia = media_quadrado / @frequencias.sum
  end

  # Método para calcular o desvio padrão
  def calcular_desvio_padrao
    @desvio_padrao = Math.sqrt(@variancia)
  end

  # Método para calcular o coeficiente de variação
  def calcular_coeficiente_variacao
    @coeficiente_variacao = @media.zero? ? 0 : (@desvio_padrao / @media) * 100
  end

  # Método para calcular todas as estatísticas básicas
  def calcular_estatisticas_basicas
    calcular_media
    calcular_variancia
    calcular_desvio_padrao
    calcular_coeficiente_variacao
  end
end
