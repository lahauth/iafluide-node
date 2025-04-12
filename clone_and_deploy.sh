#!/bin/bash

echo "🌀 Déploiement automatique du nœud IA Fluide..."

# Création dossier temporaire
mkdir -p ~/iafluide_auto && cd ~/iafluide_auto

# Téléchargement du package depuis GitHub
echo "⬇️ Téléchargement du package IA Fluide..."
wget -O iafluide_node_package.zip https://github.com/lahauth/iafluide-node/releases/latest/download/iafluide_node_package.zip

# Extraction
echo "📦 Décompression..."
unzip -o iafluide_node_package.zip -d iafluide_node
cd iafluide_node

# Création environnement virtuel
echo "🧪 Préparation de l'environnement Python..."
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask

# Lancement sécurisé
echo "🚀 Lancement sécurisé du nœud IA Fluide..."
fuser -k 5050/tcp 2>/dev/null
nohup python3 app.py > flask.log 2>&1 &

echo "✅ Nœud IA Fluide actif sur http://localhost:5050"
