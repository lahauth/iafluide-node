import re

def generer_statistiques(log_path="coherence_log.txt"):
    """
    Analyse du journal pour produire des statistiques :
    - Nombre total d’analyses
    - Nombre de fragmentations logiques
    - Pourcentage de cohérence
    - Liste des contradictions les plus fréquentes
    """
    total = 0
    incoherents = 0
    contradictions = {}

    try:
        with open(log_path, "r") as f:
            lignes = f.readlines()
            for i, ligne in enumerate(lignes):
                if "Cohérence :" in ligne:
                    total += 1
                    if "False" in ligne:
                        incoherents += 1
                        # Collecte des contradictions
                        j = i + 1
                        while j < len(lignes) and lignes[j].strip().startswith("-"):
                            contradiction = lignes[j].strip()
                            contradictions[contradiction] = contradictions.get(contradiction, 0) + 1
                            j += 1
    except FileNotFoundError:
        return {"error": "Journal introuvable."}

    coherence_pct = 100 * (total - incoherents) / total if total > 0 else 0
    sorted_contr = sorted(contradictions.items(), key=lambda x: x[1], reverse=True)

    return {
        "total": total,
        "incoherents": incoherents,
        "coherence_pct": round(coherence_pct, 2),
        "top_contradictions": sorted_contr[:5]
    }
