#language: pt

Funcionalidade: Validar tela de tarefas a fazer

# Adicionando um contexto comum para todos os cenários
Contexto: Acessar tela de tarefas a fazer
  Dado que estou acessando a tela de tarefas a fazer

# Validação da funcionalidade de limpeza da caixa de texto
@geral @to_do @limpar_caixa_texto
 Cenario: Validar a limpeza da caixa de texto
  Quando preencho a caixa de texto e clico na opção limpar
  Então valido se a caixa de texto foi limpa

# Validação da adição de tarefa na tela de tarefas a fazer
@geral @to_do @adicionar_tarefa
Cenario: Validar a inclusao de uma tarefa
 Quando adiciono uma tarefa a lista de tarefas
 Então valido se a tarefa foi salva com sucesso

 # Validação da adição de duas tarefas à lista de tarefas
@geral @to_do @adicionar_duas_tarefas
Cenario: Validar a inclusao de duas tarefas simultaneamente 
 Quando adiciono duas tarefas a lista de tarefas
 Então valido se as duas tarefas foram salvas com sucesso

# Validação da exclusão de tarefas na tela de tarefas a fazer
@geral @to_do @excluir_tarefa_a_fazer
Cenario: Validar a exclusao de tarefas
 Quando adiciono uma tarefa a lista de tarefas
 E excluo uma tarefa cadastrada
 Então valido se a tarefa foi excluida com sucesso

# Validação da conclusão de tarefas
@geral @to_do @concluir_tarefa
Cenario: Validar se a tarefa foi concluida
 Quando adiciono uma tarefa a lista de tarefas
 E marco uma tarefa como concluida 
 E a tarefa sai da lista de tarefas a fazer
 Então verifico se a tarefa está na lista de tarefas concluidas


# Validação da adição de tarefas, de nomes longos, na lista de tarefas a fazer
@geral @to_do @adicionar_tarefa_longa
Cenario: Validar a inclusao de uma tarefa de nome extenso
 Quando adiciono uma tarefa de nome extenso a lista de tarefas
 E marco uma tarefa como concluida 
 E a tarefa sai da lista de tarefas a fazer
 Então verifico se a tarefa está na lista de tarefas concluidas