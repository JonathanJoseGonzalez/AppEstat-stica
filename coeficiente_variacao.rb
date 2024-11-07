class CoeficienteVariacao
  def self.calcular(base)
    media = base.calcular_media
    desvio_padrao = Variancia.calcular_desvio_padrao(base)
    (desvio_padrao / media) * 100
  end
end
