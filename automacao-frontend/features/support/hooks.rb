require "selenium-webdriver"
require "report_builder"

$num_cenario = 0

Before do |scn|
  @todo = PaginaToDo.new
  @done = PaginaDone.new
  $helper = PaginaHelper.new

  $erro = ""

  if ($num_cenario == 0)
    $cenarios = []
  end
end

After do |scn|
  nome = scn.name
  if scn.failed?
    $helper.salvar_cenario(nome, "NOK")
  else
    $helper.salvar_cenario(nome, "OK")
  end
end

at_exit do
  $helper.criar_relatorio
end
