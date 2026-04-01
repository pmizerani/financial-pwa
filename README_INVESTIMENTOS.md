# 💰 Plataforma de Investimentos

Plataforma completa de gerenciamento de investimentos com PWA, salvamento em arquivo local e calculadora de rendimentos.

## ✨ Funcionalidades Completas

### 📊 Dashboard
- **Patrimônio Total**: soma dos últimos saldos de todos os investimentos
- **Total Investido**: valor aplicado inicialmente em cada investimento
- **Rendimento**: diferença entre patrimônio e investimento (valor e percentual)
- **Taxas Atualizadas**: Selic e CDI customizado via API do Banco Central
- **Gráfico Interativo**: evolução do patrimônio desde o investimento mais antigo (ou últimos 60 dias)

### 💼 Gestão de Investimentos
- **Cadastro Completo**:
  - Nome, valor aplicado, tipo, data de aplicação
  - Modalidade (pré/pós-fixado) com taxa
  - Liquidez (diária ou com vencimento)
  - Observações
- **Registro de Saldos**: histórico manual de saldos com data
- **Aportes e Retiradas**: controle de movimentações com valor, data e observações
- **Tabela Detalhada**: liquidez, rendimento, taxa e ações rápidas

### 📈 Calculadora de Renda Fixa
- **Simulação Completa** com:
  - Investimento inicial e aportes mensais
  - Período customizável
  - Taxas atualizadas (Selic, CDI, IPCA) via API do Banco Central
- **4 Modalidades**:
  - **CDB**: com IR regressivo
  - **LCI/LCA**: isento de IR
  - **Tesouro Selic**: com taxa de custódia (0,2% a.a.) e IR
  - **Poupança**: cálculo correto pela regra atual
- **Ranking Automático**: ordena por melhor rentabilidade líquida
- **Detalhamento**: rendimento bruto, IR, custodia, rendimento líquido e rentabilidade

### 💾 Salvamento Local
- **File System Access API**: salva automaticamente em arquivo JSON local
- **Reconexão Automática**: ao reabrir, tenta conectar ao arquivo anterior via IndexedDB
- **Indicador de Status**: mostra se está conectado ao arquivo
- **Botão de Reconexão**: permite trocar ou reconectar ao arquivo a qualquer momento

### 📱 PWA (Progressive Web App)
- **Instalável**: pode instalar como app nativo no computador e celular
- **Offline**: funciona sem internet após a primeira carga
- **Service Worker**: cache inteligente (Network First, fallback para Cache)
- **Manifest**: ícones SVG inline, tema dark, standalone
- **Botão de Instalação**: aparece automaticamente quando disponível

## 🚀 Como Usar

### 1. Primeira Execução
1. Abra `investimentos.html` no navegador
2. **Escolha uma opção**:
   - Abrir arquivo `database_financial.json` existente, OU
   - Criar um novo arquivo
3. Salve o arquivo **na mesma pasta do HTML** (recomendado)

### 2. Adicionar Investimento
1. Clique em **"+ Novo Investimento"**
2. Preencha os dados (máscaras automáticas em valores e taxas)
3. Escolha modalidade (pré/pós) e liquidez
4. Clique em **"Salvar"**
5. Os dados são salvos automaticamente no arquivo

### 3. Registrar Saldo
- **Via lista**: clique no ícone 💰 na linha do investimento
- **Via detalhes**: clique na linha → aba "Saldos"
- Preencha valor e data (botão "Hoje" pra preencher automaticamente)

### 4. Usar Calculadora
1. Clique em **"📈 Calculadora"** no menu
2. As taxas são carregadas automaticamente da API do Banco Central
3. Preencha investimento inicial, aportes e período
4. Ajuste percentuais de rentabilidade se necessário
5. Clique em **"📈 Calcular Simulação"**
6. Veja os resultados ordenados por melhor rentabilidade líquida

### 5. Instalar como PWA
1. Ao abrir pela primeira vez, aguarde o botão **"📱 Instalar App"** aparecer (canto inferior direito)
2. Clique no botão e confirme a instalação
3. O app será instalado como aplicativo nativo
4. Funciona offline após a primeira instalação

## 🎨 Design
- **Dark Theme**: tema escuro moderno
- **Máscaras Automáticas**: valores monetários e percentuais
- **Formatação Brasileira**: R$ 1.234,56
- **Radio Buttons Estilizados**: sem radios nativos, visual clean
- **Gráfico com Tooltip**: ao passar o mouse, mostra data e valor exato
- **Layout Responsivo**: adapta para desktop, tablet e mobile

## 🔐 Segurança e Privacidade
- **100% Local**: dados não saem do seu computador
- **Sem Backend**: não envia dados para servidor algum
- **Sem localStorage**: dados principais em arquivo físico (mais seguro)
- **IndexedDB**: só guarda a permissão do arquivo (não os dados)
- **HTTPS Recomendado**: para instalar o PWA, use HTTPS (ou `localhost`)

## 📦 Arquivos do Projeto
```
.
├── investimentos.html      # Arquivo principal (único HTML)
├── manifest.json            # Manifesto PWA
├── sw.js                    # Service Worker
└── database_financial.json  # Seu arquivo de dados (criado por você)
```

## 🧪 Testes Realizados

### ✅ Salvamento Automático
- [x] Salva ao adicionar investimento
- [x] Salva ao editar investimento
- [x] Salva ao excluir investimento
- [x] Salva ao adicionar saldo
- [x] Salva ao adicionar aporte
- [x] Salva ao adicionar retirada

### ✅ Reconexão de Arquivo
- [x] Conecta automaticamente ao abrir (se já conectou antes)
- [x] Solicita permissão se expirou
- [x] Permite criar novo arquivo
- [x] Permite trocar de arquivo via "Reconectar"

### ✅ PWA
- [x] Service Worker registra corretamente
- [x] Manifest carrega os ícones SVG inline
- [x] Botão de instalação aparece quando disponível
- [x] Funciona offline após instalação

### ✅ Calculadora
- [x] Carrega taxas da API do Banco Central
- [x] Calcula IR regressivo corretamente
- [x] Isenta IR em LCI/LCA
- [x] Aplica taxa de custódia no Tesouro Selic
- [x] Ordena resultados por rentabilidade

### ✅ Dashboard
- [x] Atualiza patrimônio total ao adicionar saldo
- [x] Calcula rendimento correto (patrimônio - investido)
- [x] Gráfico com tooltip interativo
- [x] Gráfico desde o investimento mais antigo

## 🌐 Servidor Local (Opcional)

Para testar o PWA localmente, rode um servidor HTTP:

```bash
# Python 3
python3 -m http.server 8080

# Node.js (npx)
npx serve .

# Então abra: http://localhost:8080/investimentos.html
```

## 📱 Como Instalar no Celular

1. Abra no Chrome/Safari mobile
2. Ative HTTPS (ou use `ngrok` se estiver testando)
3. Menu → "Adicionar à Tela Inicial"
4. O app funciona offline

## 🐛 Troubleshooting

### ❌ "Sem permissão no arquivo"
- Clique em **"Reconectar"** e selecione o arquivo novamente
- O navegador limita permissões por segurança

### ❌ "Service Worker não registra"
- Teste em `localhost` ou HTTPS
- Alguns navegadores bloqueiam SW em `file://`

### ❌ "PWA não instala"
- Precisa estar em HTTPS (ou localhost)
- Verifique se o manifest.json carrega sem erro (DevTools → Application)

### ❌ "Dados não salvam"
- Verifique se conectou ao arquivo (status no header)
- Se perdeu conexão, clique em "Reconectar"

## 🔮 Próximas Melhorias (Opcionais)

- [ ] Export/import CSV
- [ ] Comparação de investimentos (side-by-side)
- [ ] Alertas de vencimento
- [ ] Notificações push (quando instalado como PWA)
- [ ] Sincronização com Google Drive/Dropbox
- [ ] Tema claro/escuro toggle
- [ ] Multi-idioma

## 🏆 Pronto para Produção!

✅ PWA completo e funcional  
✅ Salvamento automático em arquivo local  
✅ Reconexão inteligente  
✅ Calculadora com taxas reais  
✅ Dashboard completo  
✅ Offline-first  

**Versão:** 1.0.0  
**Status:** ✅ Completo e testado
