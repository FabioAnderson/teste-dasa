require "ffaker"

class PaginaHelper
  def gerar_tarefas(qtd_tarefas)
    tarefas = ""
    for i in 1..qtd_tarefas
      tarefas += FFaker::Skill.specialty
      if (i != qtd_tarefas)
        tarefas += ";"
      end
    end
    return tarefas
  end

  def gerar_tarefa_longa
    tarefa = "#{FFaker::Skill.specialty} #{FFaker::FreedomIpsum.word} #{FFaker::DizzleIpsum.word} #{FFaker::HipsterIpsum.word}"
    tarefa += "#{FFaker::Skill.specialty} #{FFaker::FreedomIpsum.word} #{FFaker::DizzleIpsum.word} #{FFaker::HipsterIpsum.word}"
    tarefa += "#{FFaker::Skill.specialty} #{FFaker::FreedomIpsum.word} #{FFaker::DizzleIpsum.word} #{FFaker::HipsterIpsum.word}"
    tarefa = tarefa.gsub(";", "")
    tarefa = tarefa.gsub(" ", "")
    return tarefa
  end

  def salvar_cenario(nome, status)
    cenario = []
    cenario[0] = $num_cenario.to_i + 1
    cenario[1] = "#{nome}"
    cenario[2] = "#{status}"
    cenario[3] = "#{$erro}"

    $cenarios[$num_cenario] = cenario
    $num_cenario += 1
  end

  def criar_relatorio
    linha = 0
    coluna = 0

    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]
    maxcol = $cenarios[0].length - 1

    while linha < 3
      while coluna <= maxcol
        begin
          worksheet.change_column_width(coluna, 13)
        end
        coluna += 1
      end
      begin
        worksheet.change_row_height(linha, 15)
      end
      linha += 1
    end

    ################################################################
    ############## -- CONTEÚDO ESTÁTICO -- #########################

    worksheet.add_cell(0, 0, "Relatório - To Do")
    worksheet.merge_cells(0, 0, 0, 3)
    worksheet.sheet_data[0][0].change_font_bold(true)
    worksheet.sheet_data[0][0].change_fill("305496")
    worksheet.sheet_data[0][0].change_font_color("ffffff")
    worksheet.sheet_data[0][0].change_horizontal_alignment("center")
    worksheet.sheet_data[0][0].change_font_size(8)

    worksheet.add_cell(1, 0, "ID")
    worksheet.sheet_data[1][0].change_font_bold(true)
    worksheet.sheet_data[1][0].change_fill("8db4e2")
    worksheet.sheet_data[1][0].change_horizontal_alignment("center")
    worksheet.sheet_data[1][0].change_font_size(8)
    begin
      worksheet.change_column_width(0, 4)
    end

    worksheet.add_cell(1, 1, "CENÁRIO")
    worksheet.sheet_data[1][1].change_font_bold(true)
    worksheet.sheet_data[1][1].change_fill("8db4e2")
    worksheet.sheet_data[1][1].change_font_size(8)
    worksheet.sheet_data[1][1].change_horizontal_alignment("center")
    begin
      worksheet.change_column_width(1, 32)
    end
    #worksheet.change_column_width(2, 9)

    worksheet.add_cell(1, 2, "STATUS")
    worksheet.sheet_data[1][2].change_font_bold(true)
    worksheet.sheet_data[1][2].change_fill("8db4e2")
    worksheet.sheet_data[1][2].change_font_size(8)
    worksheet.sheet_data[1][2].change_horizontal_alignment("center")
    begin
      worksheet.change_column_width(2, 8)
    end

    worksheet.add_cell(1, 3, "OBSERVAÇÕES")
    worksheet.sheet_data[1][3].change_font_bold(true)
    worksheet.sheet_data[1][3].change_fill("8db3e2")
    worksheet.sheet_data[1][3].change_horizontal_alignment("center")
    worksheet.sheet_data[1][3].change_font_size(8)
    begin
      worksheet.change_column_width(3, 50)
    end
    ################################################################
    ################# -- CONTEÚDO DINÂMICO -- ######################
    linha = 0
    maxrow = $cenarios.length - 1
    while linha <= maxrow
      coluna = 0
      while coluna <= maxcol
        worksheet.add_cell(linha + 2, coluna, "#{$cenarios[linha][coluna]}")
        worksheet.sheet_data[linha + 2][coluna].change_horizontal_alignment("center")
        worksheet.sheet_data[linha + 2][coluna].change_vertical_alignment("center")
        worksheet.sheet_data[linha + 2][coluna].change_border(:left, "medium")
        worksheet.sheet_data[linha + 2][coluna].change_border(:top, "medium")
        worksheet.sheet_data[linha + 2][coluna].change_border(:right, "medium")
        worksheet.sheet_data[linha + 2][coluna].change_border(:bottom, "medium")
        worksheet.sheet_data[linha + 2][coluna].change_font_size(8)
        if $cenarios[linha][coluna] != nil
          worksheet.sheet_data[linha + 2][coluna].change_text_wrap(wrap = true)
        end
        if $cenarios[linha][coluna] == "OK"
          worksheet.sheet_data[linha + 2][coluna].change_fill("a9d08e")
        end
        if $cenarios[linha][coluna] == "NOK"
          worksheet.sheet_data[linha + 2][coluna].change_fill("f4b084")
        end
        coluna += 1
      end
      linha += 1
    end
    exportar = "data/relatorio_#{DateTime.now}.xlsx".tr(":", "-")
    workbook.write(exportar)
  end
end
