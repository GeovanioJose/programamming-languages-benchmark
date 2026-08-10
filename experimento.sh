#!/bin/bash
# =========================================================
# experimento.sh
# Roda tomada.py (medição na parede) e run.sh (benchmark)
# de forma sincronizada: começam juntos e terminam juntos.
#
# Uso:
#   ./experimento.sh <linguagem> <repeticoes> <intervalo_min>
# Exemplo:
#   ./experimento.sh python 100 10
# =========================================================

# --- Ajuste este caminho para o Python do seu venv ---
VENV_PY="$HOME/tomada-venv/bin/python"
# -----------------------------------------------------

# valida parâmetros (mesmos exigidos pelo run.sh)
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Uso: $0 <linguagem> <repeticoes> <intervalo_min>"
    exit 1
fi

if [ ! -x "$VENV_PY" ]; then
    echo "Python do venv nao encontrado em: $VENV_PY"
    echo "Edite a variavel VENV_PY no topo deste script."
    exit 1
fi

# pede a senha do sudo UMA vez, adiantado
# (run.sh usa 'sudo cat' internamente; sem isso ele pararia pra pedir senha no meio)
sudo -v || { echo "Falha na autenticacao sudo."; exit 1; }

# --- inicia a tomada em segundo plano ---
echo -e "\e[36m[experimento] Iniciando coleta da tomada...\e[0m"
"$VENV_PY" tomada.py &
TOMADA_PID=$!

# rede de seguranca: se este script morrer por qualquer motivo,
# a tomada e encerrada junto.
cleanup() {
    if kill -0 "$TOMADA_PID" 2>/dev/null; then
        echo -e "\e[36m[experimento] Encerrando coleta da tomada...\e[0m"
        kill -TERM "$TOMADA_PID" 2>/dev/null
        wait "$TOMADA_PID" 2>/dev/null
    fi
}
trap cleanup EXIT INT TERM

# pequena folga pra tomada conectar e fazer a 1a leitura antes do benchmark
sleep 2

# --- roda o benchmark (bloqueia ate terminar) ---
echo -e "\e[36m[experimento] Iniciando benchmark: $1 $2 $3\e[0m"
./run.sh "$1" "$2" "$3"
STATUS=$?

# --- encerra a tomada (o trap cuida do kill/wait) ---
echo -e "\e[36m[experimento] Benchmark finalizado (status $STATUS).\e[0m"
exit $STATUS