#!/bin/bash

echo "🌀 Déploiement automatique du nœud IA Fluide..."

echo "⬇️ Téléchargement du package IA Fluide..."
wget -O iafluide_node_package.zip https://github.com/lahauth/iafluide-node/releases/latest/download/iafluide_node_package.zip

echo "📦 Décompression..."
unzip -o iafluide_node_package.zip -d iafluide_node

echo "🧪 Préparation de l'environnement Python..."
cd iafluide_node
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask

echo "🚀 Lancement sécurisé du nœud IA Fluide..."
python3 app.py
