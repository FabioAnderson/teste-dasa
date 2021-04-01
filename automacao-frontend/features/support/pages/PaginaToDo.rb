require "ffaker"

class PaginaToDo
  include RSpec::Matchers
  include Capybara::DSL

  def acessar_tarefas_a_fazer
    if has_no_selector?(ELEMENTS["titulo"], wait: 1)
      visit ("http://localhost:8080/todo")
      sleep 1
    end

    begin
      assert_selector(ELEMENTS["titulo"])
    rescue
      $erro += "Nao carregou a pagina de tarefas a fazer"
      raise $erro
    end
  end

  def preencher_caixa_de_texto(qtd_tarefas = 1)
    tarefas = $helper.gerar_tarefas(qtd_tarefas)

    assert_selector(ELEMENTS["campo_tarefa"])
    find(ELEMENTS["campo_tarefa"]).set(tarefas)
    return tarefas
  end

  def limpar_caixa_de_texto
    assert_selector(ELEMENTS["botao_limpar"])
    find(ELEMENTS["botao_limpar"]).click
  end

  def validar_botao_limpar
    assert_selector(ELEMENTS["campo_tarefa"])

    if (find(ELEMENTS["campo_tarefa"]).value != "")
      $erro = "O texto não foi deletado da caixa de texto"
      raise $erro
    end
  end

  def adicionar_tarefa
    assert_selector(ELEMENTS["botao_adicionar"])
    find(ELEMENTS["botao_adicionar"]).click
  end

  def validar_tarefa_na_lista(tarefa)
    qtd_tarefas = tarefa.split(";").count

    if qtd_tarefas == 1
      tarefa = [tarefa]
    else
      tarefa = tarefa.split(";")
    end

    for i in 1..qtd_tarefas
      begin
        assert_selector("span", text: tarefa[i])
      rescue
        $erro = "A tarefa não foi encontrada na lista"
        raise $erro
      end
    end
  end

  def excluir_tarefa(tarefa = "qualquer")
    begin
      assert_selector("li")
    rescue
      $erro = "Não há itens na lista para serem excluidos"
      raise $erro
    end

    begin
      if (tarefa == "qualquer")
        within all("li")[0] do
          find("button").click
        end
      else
        within all("li", text: tarefa)[0] do
          find("button").click
        end
      end
    rescue
      $erro = "Não foi possivel clicar em excluir tarefa"
      raise $erro
    end
  end

  def validar_exclusao(tarefa)
    begin
      assert_no_selector("li", text: tarefa)
    rescue
      $erro = "Atividade não foi excluida"
      raise $erro
    end
  end

  def concluir_tarefa(tarefa)
    begin
      assert_selector("li")
    rescue
      $erro = "Não há itens na lista para serem concluidos"
      raise $erro
    end

    begin
      within all("li", text: tarefa)[0] do
        find("input[type='checkbox']").click
      end
    rescue
      $erro = "Não foi possivel clicar em finalizar tarefa"
      raise $erro
    end
  end

  def validar_saida_lista(tarefa)
    begin
      assert_no_selector("li", text: tarefa)
    rescue
      $erro = "Atividade não saiu da lista de tarefas"
      raise $erro
    end
  end

  def preencher_tarefa_longa
    tarefas = $helper.gerar_tarefa_longa

    assert_selector(ELEMENTS["campo_tarefa"])
    find(ELEMENTS["campo_tarefa"]).set(tarefas)
    return tarefas
  end
end
