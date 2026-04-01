# 💰 Financial PWA - Instalador para macOS

Plataforma completa de gerenciamento de investimentos com instalação automática em qualquer Mac.

## 📦 Conteúdo do Pacote

```
financial-pwa/
├── install.sh                    # 🚀 Instalador automático
├── investimentos.html            # 💻 Plataforma (HTML único)
├── manifest.json                 # 📱 Manifesto PWA
├── sw.js                         # ⚙️ Service Worker
├── README_INVESTIMENTOS.md       # 📄 Documentação da plataforma
├── SERVIDOR.md                   # 📚 Guia do servidor
└── README.md                     # 📖 Este arquivo
```

## ⚡ Instalação Rápida

### 1. Extrair o ZIP
```bash
unzip financial-pwa.zip
cd financial-pwa
```

### 2. Executar o Instalador
```bash
chmod +x install.sh
./install.sh
```

### 3. Seguir as instruções na tela

O instalador irá:
- ✅ Verificar dependências (Python 3)
- ✅ Escolher diretório de instalação (padrão: `~/Documents/financial`)
- ✅ Copiar todos os arquivos
- ✅ Configurar servidor HTTP automático
- ✅ Criar LaunchAgent para iniciar no boot
- ✅ Iniciar o servidor
- ✅ Criar script de desinstalação
- ✅ (Opcional) Criar alias `financial` no terminal

## 🎯 Requisitos

- **macOS** (qualquer versão moderna)
- **Python 3** (geralmente já vem instalado)
  - Se não tiver: `brew install python3`
  - Ou baixe: https://www.python.org/downloads/

## 🚀 Uso Após Instalação

### Abrir no navegador
```bash
# Via terminal (se criou o alias)
financial

# Ou via URL
open "http://localhost:8080/investimentos.html"
```

### Instalar como PWA
1. Abra no navegador
2. Aguarde o botão **"📱 Instalar App"** aparecer
3. Clique e confirme
4. Pronto! App instalado e funciona offline

### Gerenciar o Servidor
```bash
# Ver status
launchctl list | grep financial

# Parar
launchctl stop com.financial.server

# Iniciar
launchctl start com.financial.server

# Ver logs
tail -f ~/Documents/financial/server.log
```

## 🗑️ Desinstalar

```bash
# Execute o script de desinstalação criado automaticamente
~/Documents/financial/uninstall.sh
```

O script irá:
- Parar o servidor
- Remover o LaunchAgent
- (Opcional) Remover todos os arquivos

## 📱 Funcionalidades da Plataforma

### 💼 Gestão de Investimentos
- Cadastro completo (nome, valor, tipo, modalidade, liquidez)
- Registro manual de saldos, aportes e retiradas
- Dashboard com patrimônio total, rendimento e gráfico interativo

### 📈 Calculadora de Renda Fixa
- CDB, LCI/LCA, Tesouro Selic e Poupança
- IR regressivo automático (22,5% → 15%)
- Taxas atualizadas via API do Banco Central
- Ranking por rentabilidade líquida

### 💾 Salvamento Local
- Dados salvos em arquivo JSON local
- Reconexão automática ao reabrir
- Sem backend, sem nuvem, 100% privado

### 📱 PWA (Progressive Web App)
- Instalável como app nativo
- Funciona offline
- Ícone no Launchpad
- Não precisa do navegador aberto

## 🔧 Configuração Avançada

### Mudar Porta do Servidor

Edite o LaunchAgent:
```bash
nano ~/Library/LaunchAgents/com.financial.server.plist
```

Mude a linha:
```xml
<string>8080</string>
```

Para a porta desejada, salve e reinicie:
```bash
launchctl unload ~/Library/LaunchAgents/com.financial.server.plist
launchctl load ~/Library/LaunchAgents/com.financial.server.plist
```

### Mudar Diretório de Instalação

Durante a instalação, escolha outro caminho quando perguntado:
```
📂 Onde deseja instalar a plataforma?
   (padrão: ~/Documents/financial)
Digite o caminho ou pressione ENTER para usar o padrão: /caminho/customizado
```

### Desabilitar Início Automático

```bash
launchctl unload ~/Library/LaunchAgents/com.financial.server.plist
```

Para reabilitar:
```bash
launchctl load ~/Library/LaunchAgents/com.financial.server.plist
```

## 🐛 Troubleshooting

### ❌ "Python 3 não encontrado"
```bash
# Instalar via Homebrew
brew install python3

# Ou baixar instalador oficial
open https://www.python.org/downloads/
```

### ❌ "Porta 8080 já está em uso"
```bash
# Ver o que está usando
lsof -ti:8080

# Matar processo
kill $(lsof -ti:8080)

# Ou escolher outra porta durante instalação
```

### ❌ "Servidor não inicia"
```bash
# Ver erros
cat ~/Documents/financial/server.error.log

# Testar manualmente
cd ~/Documents/financial
python3 -m http.server 8080
```

### ❌ "PWA não instala"
- ✅ Use Chrome ou Edge (Safari não suporta bem)
- ✅ Acesse via `http://localhost:8080` (não `file://`)
- ✅ Aguarde ~10 segundos após carregar
- ✅ Verifique Console (F12) se há erros

### ❌ "Permissão negada"
```bash
# Dar permissão ao instalador
chmod +x install.sh

# Ou executar com bash explicitamente
bash install.sh
```

## 🔒 Segurança e Privacidade

- ✅ **100% Local:** dados não saem do seu computador
- ✅ **Sem Backend:** não envia dados para servidor algum
- ✅ **Localhost Only:** servidor escuta apenas em 127.0.0.1
- ✅ **Não Acessível pela Rede:** apenas você consegue acessar
- ✅ **Open Source:** código auditável e transparente

## 📚 Documentação Adicional

Após instalar, consulte:

- **Guia da Plataforma:** `~/Documents/financial/README_INVESTIMENTOS.md`
- **Guia do Servidor:** `~/Documents/financial/SERVIDOR.md`

## 🆘 Suporte

### Logs do Servidor
```bash
# Ver requisições HTTP
tail -f ~/Documents/financial/server.log

# Ver erros
tail -f ~/Documents/financial/server.error.log
```

### Verificar Status
```bash
# Ver se está rodando
launchctl list | grep financial

# Ver processo
ps aux | grep "http.server"

# Ver porta em uso
lsof -ti:8080
```

## 📝 Changelog

### v1.0.0 (Atual)
- ✅ Instalador automático para macOS
- ✅ Servidor HTTP com LaunchAgent
- ✅ PWA completo (offline-first)
- ✅ Dashboard com gráfico interativo
- ✅ Calculadora de renda fixa
- ✅ Salvamento em arquivo local
- ✅ Script de desinstalação

## 🎯 Roadmap

- [ ] Instalador para Windows
- [ ] Instalador para Linux
- [ ] Sincronização com nuvem (opcional)
- [ ] Temas personalizáveis
- [ ] Export/import CSV

## 📄 Licença

Software livre para uso pessoal e educacional.

---

**Versão:** 1.0.0  
**Data:** Abril 2024  
**Compatibilidade:** macOS 10.15+
