
#!/bin/bash
python3 -m venv venv
source venv/bin/activate
pip install flask
chmod +x *.sh
python3 activation_logger.py

echo "✅ IA Fluide installée. Lancez ./start_all_servers.sh"
