Dado("que estou na pagina done com uma tarefa concluida") do
  step "que estou acessando a tela de tarefas a fazer"
  step "adiciono uma tarefa a lista de tarefas"
  step "marco uma tarefa como concluida"
  step "a tarefa sai da lista de tarefas a fazer"
  step "verifico se a tarefa está na lista de tarefas concluidas"
end

Quando("pesquiso por uma tarefa") do
  @done.pesquisar_tarefa(@tarefa)
end

Então("valido o retorno da pesquisa") do
  @done.validar_pesquisa(@tarefa)
end

Quando("excluo uma tarefa concluida") do
  @done.excluir_tarefa(@tarefa)
end

Então("valido se a tarefa foi removida com sucesso") do
  @done.validar_exclusao(@tarefa)
end

############################################################################################
Dado("que estou na pagina de done") do
  visit ("http://localhost:8080/")
  @todo.valida_botao_adicionar
  @todo.valida_finaliza_atividade
  @todo.valida_botao_adicionar
  @todo.valida_finaliza_atividade
end

Quando("existem dados no quadro de tarefas e clico no botao de excluir um dado do quadro") do
  @done.exclui_done
end

Então("valido se o item foi excluido") do
  @done.valida_exclui_done
end
