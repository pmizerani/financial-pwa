#!/bin/bash

# 🚀 Financial PWA - Instalador Automático para macOS
# Este script configura o servidor HTTP automático e instala a plataforma

set -e  # Sair em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║        💰 Financial PWA - Instalador Automático          ║${NC}"
echo -e "${BLUE}║              Plataforma de Investimentos                  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# 1. Verificar se está no macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}❌ Este script funciona apenas no macOS${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Sistema operacional: macOS${NC}"

# 2. Verificar se Python 3 está instalado
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python 3 não encontrado${NC}"
    echo -e "${YELLOW}Por favor, instale Python 3:${NC}"
    echo "   brew install python3"
    echo "   ou baixe de: https://www.python.org/downloads/"
    exit 1
fi

PYTHON_PATH=$(which python3)
echo -e "${GREEN}✅ Python 3 encontrado: ${PYTHON_PATH}${NC}"

# 3. Perguntar diretório de instalação
echo ""
echo -e "${YELLOW}📂 Onde deseja instalar a plataforma?${NC}"
echo -e "${BLUE}   (padrão: ~/Documents/financial)${NC}"
read -p "Digite o caminho ou pressione ENTER para usar o padrão: " INSTALL_DIR

if [ -z "$INSTALL_DIR" ]; then
    INSTALL_DIR="$HOME/Documents/financial"
fi

# Expandir ~ para home directory
INSTALL_DIR="${INSTALL_DIR/#\~/$HOME}"

echo -e "${BLUE}📁 Diretório de instalação: ${INSTALL_DIR}${NC}"

# 4. Criar diretório se não existir
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}⚠️  Diretório já existe: ${INSTALL_DIR}${NC}"
    read -p "Deseja continuar e sobrescrever os arquivos? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
        echo -e "${RED}❌ Instalação cancelada${NC}"
        exit 1
    fi
else
    mkdir -p "$INSTALL_DIR"
    echo -e "${GREEN}✅ Diretório criado: ${INSTALL_DIR}${NC}"
fi

# 5. Copiar arquivos da plataforma
echo ""
echo -e "${YELLOW}📋 Copiando arquivos da plataforma...${NC}"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp "$SCRIPT_DIR/investimentos.html" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/manifest.json" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/sw.js" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/README_INVESTIMENTOS.md" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/SERVIDOR.md" "$INSTALL_DIR/"

echo -e "${GREEN}✅ Arquivos copiados${NC}"

# 6. Criar script de inicialização do servidor
echo ""
echo -e "${YELLOW}🔧 Criando script de inicialização...${NC}"

cat > "$INSTALL_DIR/start-server.sh" << EOF
#!/bin/bash
cd "$INSTALL_DIR"
$PYTHON_PATH -m http.server 8080
EOF

chmod +x "$INSTALL_DIR/start-server.sh"
echo -e "${GREEN}✅ Script criado: start-server.sh${NC}"

# 7. Perguntar porta (opcional)
echo ""
echo -e "${YELLOW}🌐 Qual porta deseja usar para o servidor?${NC}"
echo -e "${BLUE}   (padrão: 8080)${NC}"
read -p "Digite a porta ou pressione ENTER para usar a padrão: " SERVER_PORT

if [ -z "$SERVER_PORT" ]; then
    SERVER_PORT="8080"
fi

echo -e "${BLUE}🔌 Porta configurada: ${SERVER_PORT}${NC}"

# 8. Verificar se a porta está em uso
if lsof -Pi :$SERVER_PORT -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo -e "${RED}⚠️  Porta ${SERVER_PORT} já está em uso!${NC}"
    read -p "Deseja usar mesmo assim? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
        echo -e "${RED}❌ Instalação cancelada. Escolha outra porta.${NC}"
        exit 1
    fi
fi

# 9. Criar LaunchAgent
echo ""
echo -e "${YELLOW}⚙️  Configurando serviço automático...${NC}"

PLIST_PATH="$HOME/Library/LaunchAgents/com.financial.server.plist"

cat > "$PLIST_PATH" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.financial.server</string>
    
    <key>ProgramArguments</key>
    <array>
        <string>$PYTHON_PATH</string>
        <string>-m</string>
        <string>http.server</string>
        <string>$SERVER_PORT</string>
    </array>
    
    <key>WorkingDirectory</key>
    <string>$INSTALL_DIR</string>
    
    <key>RunAtLoad</key>
    <true/>
    
    <key>KeepAlive</key>
    <true/>
    
    <key>StandardOutPath</key>
    <string>$INSTALL_DIR/server.log</string>
    
    <key>StandardErrorPath</key>
    <string>$INSTALL_DIR/server.error.log</string>
</dict>
</plist>
EOF

echo -e "${GREEN}✅ LaunchAgent criado: ${PLIST_PATH}${NC}"

# 10. Carregar serviço
echo ""
echo -e "${YELLOW}🚀 Iniciando serviço...${NC}"

# Descarregar se já existir
launchctl unload "$PLIST_PATH" 2>/dev/null || true

# Carregar o novo
launchctl load "$PLIST_PATH"

# Aguardar inicialização
sleep 3

# Verificar se está rodando
if lsof -Pi :$SERVER_PORT -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    PID=$(lsof -ti:$SERVER_PORT)
    echo -e "${GREEN}✅ Servidor iniciado com sucesso!${NC}"
    echo -e "${GREEN}   PID: ${PID}${NC}"
else
    echo -e "${RED}❌ Erro ao iniciar servidor${NC}"
    echo -e "${YELLOW}Verifique os logs:${NC}"
    echo "   cat $INSTALL_DIR/server.error.log"
    exit 1
fi

# 11. Criar script de desinstalação
echo ""
echo -e "${YELLOW}🗑️  Criando script de desinstalação...${NC}"

cat > "$INSTALL_DIR/uninstall.sh" << 'UNINSTALL_EOF'
#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🗑️  Desinstalando Financial PWA...${NC}"
echo ""

read -p "Tem certeza que deseja desinstalar? (s/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
    echo -e "${RED}Desinstalação cancelada${NC}"
    exit 1
fi

# Parar e remover serviço
PLIST_PATH="$HOME/Library/LaunchAgents/com.financial.server.plist"
if [ -f "$PLIST_PATH" ]; then
    launchctl unload "$PLIST_PATH" 2>/dev/null || true
    rm "$PLIST_PATH"
    echo -e "${GREEN}✅ Serviço removido${NC}"
fi

# Perguntar se quer remover arquivos
echo ""
read -p "Deseja remover todos os arquivos? (incluindo dados) (s/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[SsYy]$ ]]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cd ~
    rm -rf "$SCRIPT_DIR"
    echo -e "${GREEN}✅ Arquivos removidos${NC}"
else
    echo -e "${YELLOW}⚠️  Arquivos mantidos em: $(dirname "${BASH_SOURCE[0]}")${NC}"
fi

echo ""
echo -e "${GREEN}✅ Desinstalação concluída!${NC}"
UNINSTALL_EOF

chmod +x "$INSTALL_DIR/uninstall.sh"
echo -e "${GREEN}✅ Script de desinstalação criado: uninstall.sh${NC}"

# 12. Criar alias para facilitar acesso
echo ""
echo -e "${YELLOW}🔗 Deseja criar um alias 'financial' no terminal?${NC}"
echo -e "${BLUE}   Permite abrir com: 'financial'${NC}"
read -p "Criar alias? (s/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[SsYy]$ ]]; then
    SHELL_CONFIG=""
    if [ -f "$HOME/.zshrc" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_CONFIG="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
        SHELL_CONFIG="$HOME/.bash_profile"
    fi
    
    if [ -n "$SHELL_CONFIG" ]; then
        # Remover alias antigo se existir
        sed -i '' '/# Financial PWA/d' "$SHELL_CONFIG" 2>/dev/null || true
        sed -i '' '/alias financial=/d' "$SHELL_CONFIG" 2>/dev/null || true
        
        # Adicionar novo alias
        echo "" >> "$SHELL_CONFIG"
        echo "# Financial PWA" >> "$SHELL_CONFIG"
        echo "alias financial='open \"http://localhost:$SERVER_PORT/investimentos.html\"'" >> "$SHELL_CONFIG"
        
        echo -e "${GREEN}✅ Alias criado em ${SHELL_CONFIG}${NC}"
        echo -e "${YELLOW}   Execute 'source ${SHELL_CONFIG}' ou abra novo terminal${NC}"
    else
        echo -e "${YELLOW}⚠️  Não foi possível criar alias (shell config não encontrado)${NC}"
    fi
fi

# 13. Resumo final
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                  ✅ INSTALAÇÃO CONCLUÍDA!                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}📂 Instalado em:${NC} ${INSTALL_DIR}"
echo -e "${GREEN}🌐 URL Local:${NC} http://localhost:${SERVER_PORT}/investimentos.html"
echo -e "${GREEN}🚀 Status:${NC} Servidor rodando (PID: $(lsof -ti:$SERVER_PORT))"
echo ""
echo -e "${YELLOW}📱 PRÓXIMOS PASSOS:${NC}"
echo ""
echo -e "${BLUE}1.${NC} Abrir no navegador:"
echo -e "   ${GREEN}open \"http://localhost:${SERVER_PORT}/investimentos.html\"${NC}"
echo ""
echo -e "${BLUE}2.${NC} Aguardar botão '📱 Instalar App' aparecer"
echo ""
echo -e "${BLUE}3.${NC} Clicar e instalar como PWA"
echo ""
echo -e "${YELLOW}📚 DOCUMENTAÇÃO:${NC}"
echo -e "   ${GREEN}cat ${INSTALL_DIR}/README_INVESTIMENTOS.md${NC}"
echo -e "   ${GREEN}cat ${INSTALL_DIR}/SERVIDOR.md${NC}"
echo ""
echo -e "${YELLOW}🎛️  GERENCIAR SERVIDOR:${NC}"
echo -e "   Parar:     ${GREEN}launchctl stop com.financial.server${NC}"
echo -e "   Iniciar:   ${GREEN}launchctl start com.financial.server${NC}"
echo -e "   Ver logs:  ${GREEN}tail -f ${INSTALL_DIR}/server.log${NC}"
echo ""
echo -e "${YELLOW}🗑️  DESINSTALAR:${NC}"
echo -e "   ${GREEN}${INSTALL_DIR}/uninstall.sh${NC}"
echo ""

# 14. Perguntar se quer abrir agora
read -p "Deseja abrir a plataforma agora? (S/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    open "http://localhost:${SERVER_PORT}/investimentos.html"
    echo -e "${GREEN}✅ Plataforma aberta no navegador!${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Aproveite sua plataforma de investimentos!${NC}"
echo ""
