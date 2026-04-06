# Auditoria de Disco PowerShell

Este projeto contém um script PowerShell desenvolvido para realizar uma auditoria detalhada do uso de armazenamento em unidades de disco. Ele ajuda a identificar rapidamente quais aplicativos instalados e quais pastas na raiz do drive estão consumindo mais espaço.

## 🚀 Funcionalidades

- **Levantamento de Aplicativos:** Varre os registros do Windows (HKLM, HKCU e WOW6432Node) para listar softwares instalados e seus tamanhos estimados.
- **Cálculo de Pastas:** Analisa recursivamente todas as pastas na raiz do drive selecionado para determinar o tamanho total ocupado.
- **Ordenação Automática:** Exibe os resultados do maior para o menor (Descendente), facilitando a identificação de "vilões" de armazenamento.
- **Saída Visual:** Utiliza cores no terminal para diferenciar as etapas do processo e facilitar a leitura das tabelas.

## 📋 Pré-requisitos

- **Windows PowerShell:** 5.1 ou superior.
- **Privilégios de Administrador:** É altamente recomendado executar o script como Administrador para que ele tenha permissão de ler pastas do sistema e registros de todos os usuários.

## 💻 Como usar

1. Abra o PowerShell como Administrador.
2. Navegue até o diretório do projeto.
3. Execute o script:

```powershell
# Para analisar o drive padrão (C:\)
.\Auditoria-Disco.ps1

# Para analisar um drive específico
.\Auditoria-Disco.ps1 -Drive "D:\"
```

## 🛠️ Detalhes Técnicos

- **Conversão:** O script converte automaticamente valores de bytes para GB com duas casas decimais.
- **Tratamento de Erros:** Utiliza `-ErrorAction SilentlyContinue` para evitar interrupções ao encontrar arquivos ou pastas protegidas pelo sistema.
- **Performance:** O tempo de execução da análise de pastas depende diretamente da velocidade do disco (SSD/HDD) e da quantidade de arquivos.

---

_Projeto criado para fins de estudo e manutenção de sistemas._
