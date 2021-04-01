Dado("que estou acessando a tela de tarefas a fazer") do
  @todo.acessar_tarefas_a_fazer
end

E("preencho a caixa de texto e clico na opção limpar") do
  @todo.preencher_caixa_de_texto
  @todo.limpar_caixa_de_texto
end

Então("valido se a caixa de texto foi limpa") do
  @todo.validar_botao_limpar
end

Quando("adiciono uma tarefa a lista de tarefas") do
  @tarefa = @todo.preencher_caixa_de_texto
  @todo.adicionar_tarefa
end

Então("valido se a tarefa foi salva com sucesso") do
  @todo.validar_tarefa_na_lista(@tarefa)
end

Quando("adiciono duas tarefas a lista de tarefas") do
  @tarefa = @todo.preencher_caixa_de_texto(2)
  @todo.adicionar_tarefa
end

Então("valido se as duas tarefas foram salvas com sucesso") do
  step "valido se a tarefa foi salva com sucesso"
end

E("excluo uma tarefa cadastrada") do
  @todo.excluir_tarefa(@tarefa)
end

Então("valido se a tarefa foi excluida com sucesso") do
  @todo.validar_exclusao(@tarefa)
end

E("marco uma tarefa como concluida") do
  @todo.concluir_tarefa(@tarefa)
end

E("a tarefa sai da lista de tarefas a fazer") do
  @todo.validar_saida_lista(@tarefa)
end

Então("verifico se a tarefa está na lista de tarefas concluidas") do
  @done.validar_conclusao(@tarefa)
end

Quando("adiciono uma tarefa de nome extenso a lista de tarefas") do
  @tarefa = @todo.preencher_tarefa_longa
  @todo.adicionar_tarefa
end
