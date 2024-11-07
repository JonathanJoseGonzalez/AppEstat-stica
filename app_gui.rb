require 'gtk3'
require_relative 'estatistica/base_estatistica'
require_relative 'estatistica/calculo_factory'
require 'fileutils'

class EstatisticaAppGUI
  def initialize
    @estatistica = EstatisticaBase.new
    @resultados = ""

    # Configuração da Janela Principal
    @window = Gtk::Window.new
    @window.set_title("App de Estatísticas")
    @window.set_default_size(520, 539)
    @window.set_resizable(true)
    @window.set_window_position(:center)
    @window.signal_connect("destroy") { Gtk.main_quit }

    # Layout Principal com Scroll
    scroll = Gtk::ScrolledWindow.new
    scroll.set_policy(:automatic, :automatic)

    vbox = Gtk::Box.new(:vertical, 5)
    vbox.margin = 10
    scroll.add(vbox)
    @window.add(scroll)

    # Configuração da Interface
    bem_vindo_label = Gtk::Label.new("Bem-vindo ao App de Estatísticas! Insira os dados e frequências para cálculos.")
    vbox.pack_start(bem_vindo_label, expand: false, fill: false, padding: 5)

    # Entrada de Dados
    vbox.pack_start(Gtk::Label.new("Dados (separados por vírgula):"), expand: false, fill: false, padding: 5)
    @dados_entry = Gtk::Entry.new
    vbox.pack_start(@dados_entry, expand: false, fill: false, padding: 5)

    vbox.pack_start(Gtk::Label.new("Frequências (separados por vírgula):"), expand: false, fill: false, padding: 5)
    @frequencias_entry = Gtk::Entry.new
    vbox.pack_start(@frequencias_entry, expand: false, fill: false, padding: 5)

    # Botão de Calcular Estatísticas Básicas
    calc_button = Gtk::Button.new(label: "Calcular Estatísticas Básicas")
    calc_button.signal_connect("clicked") { calcular_estatisticas_basicas }
    vbox.pack_start(calc_button, expand: false, fill: false, padding: 10)

    # Botões para Outros Cálculos
    ["Agrupamento em Classes", "Agrupamento Discreto", "Distribuição Normal", "Distribuição Exponencial", "Distribuição Binomial", "Distribuição Uniforme", "Distribuição de Poisson", "Regressão Linear"].each_with_index do |label, index|
      button = Gtk::Button.new(label: label)
      button.signal_connect("clicked") { abrir_janela_parametros_calculo(index + 1) }
      vbox.pack_start(button, expand: false, fill: false, padding: 3)
    end

    # Botão de Download e Minimizar
    download_button = Gtk::Button.new(label: "Baixar Resultados")
    download_button.signal_connect("clicked") { salvar_resultados }
    vbox.pack_start(download_button, expand: false, fill: false, padding: 5)

    minimizar_button = Gtk::Button.new(label: "Minimizar")
    minimizar_button.signal_connect("clicked") { @window.iconify }
    vbox.pack_start(minimizar_button, expand: false, fill: false, padding: 5)

    # Estilo dos Botões e Janelas
    provider = Gtk::CssProvider.new
    provider.load(data: <<-CSS)
      button {
        background-color: #5A5A5A;
        color: #FF0000;
        font-size: 12px;
        border: 1px solid #000000;
      }
    CSS
    Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_USER)

    @window.show_all
  end

  def calcular_estatisticas_basicas
    dados = @dados_entry.text.split(',').map(&:to_f)
    frequencias = @frequencias_entry.text.split(',').map(&:to_i)

    @estatistica.dados = dados
    @estatistica.frequencias = frequencias
    @estatistica.calcular_estatisticas_basicas

    @resultados = <<~RESULTADO
      Média: #{@estatistica.media}
      Variância: #{@estatistica.variancia.round(2)}
      Desvio Padrão: #{@estatistica.desvio_padrao.round(2)}
      Coeficiente de Variação: #{@estatistica.coeficiente_variacao.round(2)}%
    RESULTADO

    exibir_resultado("Estatísticas Básicas", @resultados)
  end

  def abrir_janela_parametros_calculo(opcao)
    if opcao == 1
      dialog = Gtk::Dialog.new(title: "Agrupamento em Classes", parent: @window, flags: :modal)
      dialog.set_default_size(300, 200)
      content_area = dialog.child
      content_area.pack_start(Gtk::Label.new("Insira o número de classes:"), expand: false, fill: false, padding: 5)
      num_classes_entry = Gtk::Entry.new
      content_area.pack_start(num_classes_entry, expand: false, fill: false, padding: 5)

      calcular_button = Gtk::Button.new(label: "Calcular")
      calcular_button.signal_connect("clicked") do
        num_classes = num_classes_entry.text.to_i
        resultado = CalculoFactory.realizar_calculo(opcao, @estatistica, num_classes: num_classes)
        exibir_resultado("Agrupamento em Classes", resultado)
        dialog.destroy
      end
      content_area.pack_start(calcular_button, expand: false, fill: false, padding: 5)

      dialog.show_all
    else
      resultado = CalculoFactory.realizar_calculo(opcao, @estatistica)
      exibir_resultado("Cálculo Adicional", resultado)
    end
  end

  def exibir_resultado(titulo, mensagem)
    dialog = Gtk::Dialog.new(title: titulo, parent: @window, flags: :modal)
    dialog.set_default_size(300, 200)

    content_area = dialog.child
    label = Gtk::Label.new(mensagem)
    content_area.pack_start(label, expand: true, fill: true, padding: 10)

    close_button = Gtk::Button.new(label: "Fechar")
    close_button.signal_connect("clicked") { dialog.destroy }
    content_area.pack_start(close_button, expand: false, fill: false, padding: 5)

    dialog.show_all
  end

  def salvar_resultados
    diretorio_download = File.join(Dir.home, "Downloads")
    FileUtils.mkdir_p(diretorio_download)
    caminho_arquivo = File.join(diretorio_download, "resultados_estatistica.txt")
    File.open(caminho_arquivo, "w") { |file| file.puts("Resultados de Estatísticas:\n\n#{@resultados}") }
    exibir_resultado("Download", "Resultados salvos em #{caminho_arquivo}")
  end

  def run
    Gtk.main
  end
end

app = EstatisticaAppGUI.new
app.run
