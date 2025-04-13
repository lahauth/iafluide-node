#!/bin/bash

echo "🔄 Démarrage intelligent des serveurs IA Fluide..."

# Libération des ports si déjà utilisés
fuser -k 5050/tcp > /dev/null 2>&1
fuser -k 8005/tcp > /dev/null 2>&1

# Activation de l'environnement virtuel s'il existe
if [ -f venv/bin/activate ]; then
    echo "✅ Activation de l'environnement virtuel..."
    source venv/bin/activate
else
    echo "⚠️ Aucun environnement virtuel détecté (venv manquant)"
fi

# Démarrage du serveur Flask
echo "🚀 Lancement du serveur Flask (port 5050)..."
nohup python3 app.py > flask.log 2>&1 &

# Démarrage du serveur HTTP (port 8005)
if [ -d static ]; then
    echo "🌐 Lancement du serveur HTTP statique (port 8005)..."
    nohup python3 -m http.server 8005 --directory static > http.log 2>&1 &
else
    echo "⚠️ Dossier 'static/' introuvable. Serveur HTTP non lancé."
fi

echo "✅ Tous les services sont en cours de démarrage."
