#language: pt

Funcionalidade: Validar quadro de tarefas concluidas

# Adicionando um contexto comum para todos os cenários
Contexto: Acessar tela de tarefas concluidas
  Dado que estou na pagina done com uma tarefa concluida

# Validação da pesquisa de tarefas em tarefas concluidas 
@geral @done @pesquisar_tarefa_concluida
Cenario: Validar pesquisa de tarefas concluidas
 Quando pesquiso por uma tarefa
 Então valido o retorno da pesquisa


# Validação a exclusao de dados do quadro de tarefas concluidas 
@geral @done @excluir_tarefa_concluida
Cenario: Validar exclusão de tarefas concluidas
 Quando excluo uma tarefa concluida
 Então valido se a tarefa foi removida com sucesso

 