class DistribuicaoNormal
  def self.calcular(base, valor)
    media = base.calcular_media
    desvio_padrao = Variancia.calcular_desvio_padrao(base)
    z = (valor - media) / desvio_padrao

    # Função de distribuição acumulada
    cdf = 0.5 * (1 + Math.erf(z / Math.sqrt(2)))
    puts "Para o valor #{valor}, a área acumulada (CDF) é aproximadamente: #{(cdf * 100).round(2)}%"
  end
end
