import re
from datetime import datetime

def analyse(texte):
    """
    Analyse fluide : détection d’incohérences et génération de suggestions.
    """
    contradictions = []
    suggestions = []

    # Exemples simples de contradiction logique (à étendre)
    motifs = [
        ("je suis heureux", "je suis triste"),
        ("tout est vrai", "tout est faux"),
        ("je veux partir", "je veux rester"),
        ("c'est bien", "c'est mal"),
    ]

    for couple in motifs:
        if couple[0] in texte and couple[1] in texte:
            contradictions.append(couple)
            # Proposition d'une synthèse ou reformulation fluide
            suggestion = f"Peut-être veux-tu dire : « Malgré que {couple[0]}, il est aussi possible que {couple[1]}. »"
            suggestions.append(suggestion)

    coherence = len(contradictions) == 0

    # Journalisation
    with open("coherence_log.txt", "a") as log:
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log.write(f"[{now}] Cohérence : {coherence} | Texte : {texte.strip()[:100]}\n")
        for couple in contradictions:
            log.write(f" - Contradiction : '{couple[0]}' / '{couple[1]}'\n")

    return coherence, contradictions, suggestions
