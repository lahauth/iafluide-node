from flask import Flask, request, jsonify, render_template
from modules import coherence, stats_analyse, session_memory

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/test-coherence", methods=["POST"])
def test_coherence():
    data = request.get_json()
    texte = data.get("texte", "")
    coherence_result, contradictions, suggestions = coherence.analyse(texte)

    # Sauvegarde uniquement si incohérent
    if not coherence_result:
        session_memory.sauvegarder_fragmentation(texte, contradictions)

    return jsonify({
        "coherence": coherence_result,
        "contradictions": contradictions,
        "suggestions": suggestions
    })

@app.route("/log-coherence")
def log_coherence():
    try:
        with open("coherence_log.txt", "r") as log_file:
            contenu = log_file.read()
        return contenu
    except FileNotFoundError:
        return "Journal introuvable."

@app.route("/stats-coherence")
def stats_coherence():
    try:
        stats = stats_analyse.generer_statistiques()
        return jsonify(stats)
    except Exception as e:
        return jsonify({"error": str(e)})
