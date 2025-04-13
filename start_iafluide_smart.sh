#!/bin/bash

echo "🔁 Démarrage automatique IA Fluide..."

cd ~/ia-fluide/iafluide_node/ || exit 1

# Vérifie si le port 5050 est déjà utilisé
if lsof -i :5050 >/dev/null; then
    echo "⚠️ Port 5050 occupé. Tentative de libération..."
    PID=$(lsof -ti:5050)
    kill -9 "$PID"
    echo "✅ Port 5050 libéré (PID $PID)"
fi

# Active l’environnement virtuel si disponible
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    echo "✅ Environnement activé"
else
    echo "❌ Environnement virtuel introuvable"
    exit 1
fi

# Lance le serveur Flask en arrière-plan
nohup python3 app.py > flask_autostart.log 2>&1 &

echo "🚀 IA Fluide démarrée automatiquement"
