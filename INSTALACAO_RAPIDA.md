# 🚀 INSTALAÇÃO RÁPIDA - Financial PWA

## ⚡ 3 Passos para Instalar

### 1️⃣ Extrair o ZIP
```bash
unzip financial-pwa.zip
cd financial
```

### 2️⃣ Executar o Instalador
```bash
chmod +x install.sh
./install.sh
```

### 3️⃣ Seguir as instruções na tela ✅

---

## 📋 O que o instalador faz?

1. ✅ Verifica se Python 3 está instalado
2. ✅ Pergunta onde instalar (padrão: `~/Documents/financial`)
3. ✅ Copia todos os arquivos
4. ✅ Pergunta qual porta usar (padrão: `8080`)
5. ✅ Configura servidor automático (inicia no boot)
6. ✅ Inicia o servidor agora
7. ✅ Cria script de desinstalação
8. ✅ (Opcional) Cria alias `financial` no terminal
9. ✅ Abre no navegador

---

## 🎯 Após Instalar

### Abrir a plataforma:
```bash
open "http://localhost:8080/investimentos.html"

# Ou se criou o alias:
financial
```

### Instalar como PWA:
1. Aguarde o botão **"📱 Instalar App"** (canto inferior direito)
2. Clique e confirme
3. Pronto! Funciona offline

---

## 🎛️ Gerenciar Servidor

```bash
# Ver se está rodando
launchctl list | grep financial

# Parar
launchctl stop com.financial.server

# Iniciar
launchctl start com.financial.server

# Ver logs
tail -f ~/Documents/financial/server.log
```

---

## 🗑️ Desinstalar

```bash
~/Documents/financial/uninstall.sh
```

---

## ❓ Problemas?

### Python 3 não encontrado
```bash
brew install python3
```

### Porta 8080 em uso
```bash
kill $(lsof -ti:8080)
```

### Servidor não inicia
```bash
cat ~/Documents/financial/server.error.log
```

---

## 📚 Documentação Completa

Veja os arquivos após instalar:
- `README.md` - Guia completo do instalador
- `README_INVESTIMENTOS.md` - Guia da plataforma
- `SERVIDOR.md` - Gerenciamento do servidor

---

**Pronto!** 🎉 Seu servidor inicia automaticamente sempre que ligar o Mac!
