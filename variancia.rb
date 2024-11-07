class Variancia
  def self.calcular_variancia(base)
    # Cálculo de variância usando base.dados e base.frequencias
  end

  def self.calcular_desvio_padrao(base)
    Math.sqrt(calcular_variancia(base))
  end
end
