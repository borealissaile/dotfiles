**Atue como um Engenheiro DevOps Sênior e Especialista em Segurança Linux.**

Preciso que você faça uma auditoria completa e revisão de código no meu repositório de dotfiles (focado em Arch Linux e Hyprland). Seu objetivo é garantir que o sistema esteja funcional, bem documentado e seguro para ser publicado no GitHub.

Por favor, execute as seguintes tarefas detalhadamente:

**1. Análise de Configurações (Dotfiles):**

- Revise todo o código dos arquivos de configuração.
- Identifique erros de sintaxe, redundâncias, conflitos ou más práticas.
- Sugira melhorias de performance ou organização.

**2. Consistência do Script de Instalação (`install.sh`):**

- Cruze as configurações atuais dos dotfiles com o script install.sh.

- Verifique se todas as dependências, pacotes e ferramentas necessárias para o funcionamento das configurações recentes estão incluídas e sendo instaladas corretamente no script. Você DEVE manter a estrutura original do script, incluindo apenas aquilo que for estritamente necessário.

**3. Auditoria de Segurança (Anti-Vazamento):**

- Faça uma varredura rigorosa em todos os arquivos em busca de informações sensíveis que **não devem** ser enviadas ao GitHub.
- Alerte sobre: chaves de API, tokens, senhas, e-mails privados, endereços IP, ou caminhos de diretórios absolutos que exponham dados pessoais.

**4. Revisão da Documentação (`README.md`):**

- Analise se o `README.md` está coerente com as configurações atuais.
- Verifique se os passos de instalação e os requisitos de sistema estão claros, precisos e refletem exatamente o que está no `install.sh`.

**Formato de Saída Esperado:**
Entregue um relatório estruturado e direto ao ponto, dividido nas seguintes categorias:

- 🚨 **Riscos Críticos de Segurança** (O que remover/mascarar antes do _git push_).
- 🐛 **Erros de Código ou Sintaxe**.
- 📦 **Inconsistências no `install.sh`**.
- 📝 **Ajustes necessários no `README.md`**.
