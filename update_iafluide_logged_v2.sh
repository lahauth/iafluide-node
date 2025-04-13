#!/bin/bash

LOG_FILE="logs/update_$(date +%Y%m%d_%H%M%S).log"

echo "📘 Initialisation de la mise à jour..." | tee -a "$LOG_FILE"

cd ~/ia-fluide/iafluide_node/ || exit 1

mkdir -p logs
mkdir -p static/logs

function stop_server_if_running {
    if lsof -i :5050 > /dev/null 2>&1; then
        echo "🛑 Serveur sur 5050 détecté – arrêt en cours..." | tee -a "$LOG_FILE"
        fuser -k 5050/tcp 2>/dev/null
        sleep 1
    else
        echo "✅ Aucun serveur actif sur le port 5050." | tee -a "$LOG_FILE"
    fi
}

stop_server_if_running

echo "⚙️ Activation de l'environnement virtuel..." | tee -a "$LOG_FILE"
source venv/bin/activate

echo "📁 Synchronisation des nouveaux fichiers (si trouvés)..." | tee -a "$LOG_FILE"
cp -u ~/Downloads/app.py modules/ 2>>"$LOG_FILE" && echo "→ app.py mis à jour." | tee -a "$LOG_FILE"
cp -u ~/Downloads/session_memory.py modules/ 2>>"$LOG_FILE" && echo "→ session_memory.py mis à jour." | tee -a "$LOG_FILE"
cp -u ~/Downloads/index.html templates/ 2>>"$LOG_FILE" && echo "→ index.html mis à jour." | tee -a "$LOG_FILE"

echo "🚀 Redémarrage du serveur Flask..." | tee -a "$LOG_FILE"
python3 app.py | tee -a "$LOG_FILE"

# Copier aussi le journal vers le dossier static pour affichage web
cp "$LOG_FILE" static/logs/
