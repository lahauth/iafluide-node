#!/bin/bash

echo "🧠 Démarrage intelligent du serveur IA Fluide..."

cd ~/ia-fluide/iafluide_node/ || { echo "❌ Dossier introuvable"; exit 1; }

# Vérifier si le port est occupé
if lsof -i :5050 > /dev/null; then
    echo "⚠️ Port 5050 occupé — tentative de libération..."
    fuser -k 5050/tcp 2>/dev/null
    sleep 1
else
    echo "✅ Port 5050 libre."
fi

# Activation de l'environnement virtuel
echo "⚙️ Activation venv..."
source venv/bin/activate

# Lancement avec log de contrôle
echo "🚀 Lancement du serveur Flask (avec log)..."
python3 app.py > flask.log 2>&1 &

sleep 2

# Vérification si lancement OK
if lsof -i :5050 > /dev/null; then
    echo "✅ Serveur lancé avec succès sur le port 5050."
else
    echo "❌ Le serveur n'a pas démarré. Affichage du log d'erreur :"
    tail -n 20 flask.log
fi
