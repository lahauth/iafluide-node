#!/bin/bash

echo "🧠 Mise à jour intelligente du nœud IA Fluide..."

cd ~/ia-fluide/iafluide_node/ || exit 1

# Fonction pour arrêter proprement si nécessaire
function stop_server_if_running {
    if lsof -i :5050 > /dev/null 2>&1; then
        echo "🛑 Serveur détecté sur le port 5050. Arrêt en cours..."
        fuser -k 5050/tcp 2>/dev/null
        sleep 1
    fi
}

# Étape 1 : Arrêt si actif
stop_server_if_running

# Étape 2 : Activation environnement virtuel
echo "⚙️ Activation de l'environnement virtuel..."
source venv/bin/activate

# Étape 3 : Mise à jour automatique des fichiers si nécessaire (ex: copie depuis Téléchargements)
echo "📁 Synchronisation des nouveaux fichiers (si trouvés)..."
cp -u ~/Downloads/app.py modules/ 2>/dev/null
cp -u ~/Downloads/session_memory.py modules/ 2>/dev/null
cp -u ~/Downloads/index.html templates/ 2>/dev/null

# Étape 4 : Redémarrage
echo "🚀 Relancement du serveur Flask..."
python3 app.py
