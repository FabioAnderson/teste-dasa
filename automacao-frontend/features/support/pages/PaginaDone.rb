require "ffaker"

class PaginaDone
  include RSpec::Matchers
  include Capybara::DSL

  def validar_conclusao(tarefa)
    assert_selector(ELEMENTS["botao_tela_done"])
    find(ELEMENTS["botao_tela_done"]).click

    sleep 1

    begin
      assert_selector("li", text: tarefa)
    rescue
      $erro = "Atividade não consta na lista de concluidas"
      raise $erro
    end
  end

  def pesquisar_tarefa(tarefa)
    assert_selector(ELEMENTS["campo_buscar"])
    find(ELEMENTS["campo_buscar"]).set(tarefa)
  end

  def validar_pesquisa(tarefa)
    begin
      assert_selector("li", text: tarefa)
    rescue
      $erro = "Atividade não consta na pesquisa"
      raise $erro
    end
  end

  def excluir_tarefa(tarefa)
    begin
      assert_selector("li")
    rescue
      $erro = "Não há itens na lista para serem excluidos"
      raise $erro
    end

    begin
      within all("li", text: tarefa)[0] do
        find("button").click
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
end
