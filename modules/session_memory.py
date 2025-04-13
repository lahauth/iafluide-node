import json
import os
from datetime import datetime

# Nouveau chemin vers la mémoire visible par l'interface
MEMOIRE_PATH = os.path.join("static", "memoires", "fragmentations.json")

def sauvegarder_fragmentation(texte, contradictions):
    # Créer le dossier s'il n'existe pas
    os.makedirs(os.path.dirname(MEMOIRE_PATH), exist_ok=True)

    fragment = {
        "texte": texte,
        "contradictions": contradictions,
        "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    }

    memoire = []
    if os.path.exists(MEMOIRE_PATH):
        try:
            with open(MEMOIRE_PATH, "r") as f:
                memoire = json.load(f)
        except json.JSONDecodeError:
            memoire = []

    memoire.append(fragment)

    with open(MEMOIRE_PATH, "w") as f:
        json.dump(memoire, f, indent=2, ensure_ascii=False)
