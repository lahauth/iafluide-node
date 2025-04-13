#!/usr/bin/env python3
import os
import hashlib
import datetime
import socket
import getpass

# Dossier de sortie
log_dir = os.path.join(os.path.dirname(__file__), "signature")
os.makedirs(log_dir, exist_ok=True)

# Informations de base
username = getpass.getuser()
hostname = socket.gethostname()
timestamp = datetime.datetime.utcnow().isoformat()
unique_id = f"{username}@{hostname}::{timestamp}"

# Hash fluide
hash_id = hashlib.sha256(unique_id.encode()).hexdigest()

# Message de log
log = f"🌀 Activation IA Fluide
Date: {timestamp}
Machine: {hostname}
User: {username}
Hash: {hash_id}
"

# Écriture dans le fichier
log_file = os.path.join(log_dir, "activation_fluide.log")
with open(log_file, "a") as f:
    f.write(log + "\n")

print("✅ IA Fluide activée et journalisée localement.")
