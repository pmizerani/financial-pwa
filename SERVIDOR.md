# 🚀 Servidor Automático - Financial PWA

## ✅ Status: ATIVO E CONFIGURADO

O servidor HTTP está rodando automaticamente e inicia sempre que você ligar o Mac!

---

## 📍 Acesso

**URL Local:**
```
http://localhost:8080/investimentos.html
```

**Abrir no navegador:**
```bash
open "http://localhost:8080/investimentos.html"
```

---

## 🎛️ Gerenciamento do Serviço

### Ver Status
```bash
# Ver se está rodando
launchctl list | grep financial

# Ver processo na porta 8080
lsof -ti:8080

# Ver detalhes do processo
ps -p $(lsof -ti:8080)
```

### Parar o Servidor
```bash
launchctl stop com.financial.server
```

### Iniciar o Servidor
```bash
launchctl start com.financial.server
```

### Reiniciar o Servidor
```bash
launchctl stop com.financial.server
launchctl start com.financial.server
```

### Desabilitar (não inicia mais no boot)
```bash
launchctl unload ~/Library/LaunchAgents/com.financial.server.plist
```

### Reabilitar
```bash
launchctl load ~/Library/LaunchAgents/com.financial.server.plist
```

### Remover Completamente
```bash
launchctl unload ~/Library/LaunchAgents/com.financial.server.plist
rm ~/Library/LaunchAgents/com.financial.server.plist
```

---

## 📊 Logs

### Ver Logs em Tempo Real
```bash
# Log normal (requisições HTTP)
tail -f /Users/phelipemizerani/Documents/financial/server.log

# Log de erros
tail -f /Users/phelipemizerani/Documents/financial/server.error.log
```

### Ver Últimas Linhas
```bash
tail -20 /Users/phelipemizerani/Documents/financial/server.log
```

---

## 📱 Instalando o PWA

1. **Abra no Chrome/Edge:**
   ```
   http://localhost:8080/investimentos.html
   ```

2. **Aguarde o botão aparecer:**
   - Botão **"📱 Instalar App"** no canto inferior direito

3. **Clique e confirme**

4. **Pronto!** O app aparece no Launchpad

---

## 🔧 Arquivos do Sistema

### LaunchAgent (configuração do serviço)
```
~/Library/LaunchAgents/com.financial.server.plist
```

### Script do servidor (não usado mais, mas mantido)
```
/Users/phelipemizerani/Documents/financial/start-server.sh
```

### Logs
```
/Users/phelipemizerani/Documents/financial/server.log
/Users/phelipemizerani/Documents/financial/server.error.log
```

---

## 🎯 Como Funciona

1. **No boot do Mac:**
   - macOS carrega todos os LaunchAgents em `~/Library/LaunchAgents/`
   - Encontra `com.financial.server.plist`
   - Executa: `/opt/homebrew/bin/python3 -m http.server 8080`
   - WorkingDirectory: `/Users/phelipemizerani/Documents/financial`

2. **Servidor roda continuamente:**
   - Se cair (crash), o `KeepAlive=true` reinicia automaticamente
   - Fica escutando na porta 8080
   - Serve os arquivos da pasta `financial/`

3. **Acesso local:**
   - Qualquer navegador pode acessar `http://localhost:8080`
   - Apenas você (localhost) tem acesso, não é público

---

## 🆘 Troubleshooting

### Porta 8080 já em uso
```bash
# Ver o que está usando
lsof -ti:8080

# Matar processo
kill $(lsof -ti:8080)

# Reiniciar serviço
launchctl start com.financial.server
```

### Servidor não inicia
```bash
# Ver erros
cat /Users/phelipemizerani/Documents/financial/server.error.log

# Testar manualmente
cd /Users/phelipemizerani/Documents/financial
/opt/homebrew/bin/python3 -m http.server 8080
```

### PWA não instala
- ✅ Certifique-se que está em `http://localhost:8080` (não `file://`)
- ✅ Use Chrome ou Edge (Safari não suporta bem PWA)
- ✅ Aguarde ~5 segundos após carregar a página
- ✅ Verifique Console (F12) se há erros no Service Worker

---

## 🔒 Segurança

- ✅ Servidor escuta **apenas** em `localhost` (127.0.0.1)
- ✅ Não é acessível pela rede local ou internet
- ✅ Apenas você no seu Mac consegue acessar
- ✅ Dados ficam 100% locais

---

## 📝 Próximos Passos

1. **Testar instalação do PWA:**
   ```bash
   open "http://localhost:8080/investimentos.html"
   ```
   Aguardar botão de instalação aparecer

2. **Criar arquivo de dados:**
   - Ao abrir o PWA, criar `database_financial.json` na mesma pasta

3. **Adicionar PWA aos Login Items (opcional):**
   - System Settings → Users & Groups → Login Items
   - Adicionar o app instalado (fica em `~/Applications/Chrome Apps.localized/`)

---

**Status do Servidor:** 🟢 ONLINE  
**PID:** $(lsof -ti:8080 2>/dev/null || echo "não rodando")  
**URL:** http://localhost:8080/investimentos.html
