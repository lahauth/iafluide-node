#!/bin/bash

echo "🌀 Déploiement automatique du nœud IA Fluide..."

echo "⬇️ Téléchargement du package IA Fluide (v1.1.5)..."
wget -O iafluide_node_package.tar.gz https://github.com/lahauth/iafluide-node/releases/download/v1.1.5/iafluide_node_package_v1.1.5.tar.gz

echo "📦 Décompression..."
rm -rf iafluide_node
mkdir iafluide_node
tar -xzf iafluide_node_package.tar.gz -C iafluide_node

echo "🧪 Préparation de l'environnement Python..."
cd iafluide_node
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask

echo "🚀 Lancement sécurisé du nœud IA Fluide..."
python3 app.py

