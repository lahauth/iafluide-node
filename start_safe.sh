#!/bin/bash

echo "🧠 Lancement sécurisé du serveur IA Fluide..."

cd ~/ia-fluide/iafluide_node/ || exit 1

# Activer l'environnement virtuel
source venv/bin/activate

# Fermer tout processus utilisant le port 5050
echo "🔧 Libération du port 5050..."
fuser -k 5050/tcp 2>/dev/null

# Lancer le serveur Flask
echo "🚀 Démarrage de Flask sur le port 5050..."
python3 app.py
