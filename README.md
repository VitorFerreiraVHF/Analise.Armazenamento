# Ferramentas de Auditoria de Armazenamento PowerShell

Este repositório contém scripts PowerShell desenvolvidos para realizar auditorias detalhadas do uso de armazenamento. Eles permitem identificar rapidamente quais aplicativos e pastas estão consumindo mais espaço em disco.

## 🚀 Funcionalidades

- **Auditoria Completa (`Auditoria-Disco.ps1`):** Varre os registros do Windows (HKLM, HKCU e WOW6432Node) para listar softwares e analisa as pastas na raiz de um drive (ex: C:\).
- **Análise de Subpastas (`Analisa-SubPastas.ps1`):** Foca em um diretório específico para listar o tamanho de cada subpasta contida nele, ideal para limpar diretórios de projetos ou downloads.
- **Ordenação Automática:** Exibe os resultados do maior para o menor (Descendente), facilitando a identificação de "vilões" de armazenamento.
- **Conversão de Unidades:** Converte automaticamente bytes para GB para facilitar a leitura.
- **Saída Visual:** Interface colorida no terminal para melhor acompanhamento do progresso.

## 📋 Pré-requisitos

- **Windows PowerShell:** 5.1 ou superior.
- **Privilégios de Administrador:** É altamente recomendado executar o script como Administrador para que ele tenha permissão de ler pastas do sistema e registros de todos os usuários.

## 💻 Como usar

1. Abra o PowerShell como Administrador.
2. Navegue até o diretório do projeto.
3. Execute o script:

### Auditoria Geral do Drive

```powershell
# Analisa o drive padrão (C:\) - Apps instalados + Pastas da Raiz
.\Auditoria-Disco.ps1

# Analisa um drive específico
.\Auditoria-Disco.ps1 -Drive "D:\"
```

### Análise de Subpastas Específicas

```powershell
# Analisa o tamanho de cada subpasta dentro de um caminho específico
.\Analisa-SubPastas.ps1 -Path "C:\Users\NomeUsuario\Documents"
```

## 🛠️ Detalhes Técnicos

- **Conversão:** O script converte automaticamente valores de bytes para GB com duas casas decimais.
- **Tratamento de Erros:** Utiliza `-ErrorAction SilentlyContinue` para evitar interrupções ao encontrar arquivos ou pastas protegidas pelo sistema.
- **Performance:** O tempo de execução da análise de pastas depende diretamente da velocidade do disco (SSD/HDD) e da quantidade de arquivos.

---

_Projeto criado para fins de estudo e manutenção de sistemas._
