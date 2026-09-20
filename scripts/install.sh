#!/bin/bash

set -e

echo "Installing Flask application..."

cd /opt/flask-cicd

echo "Creating virtual environment..."

python3 -m venv venv

echo "Activating virtual environment..."

source venv/bin/activate

echo "Installing dependencies..."

pip install --upgrade pip
pip install -r requirements.txt

echo "Creating Flask systemd service..."

cat > /etc/systemd/system/flask-cicd.service <<EOF
[Unit]
Description=Flask CI/CD Application
After=network.target

[Service]
User=root
WorkingDirectory=/opt/flask-cicd
ExecStart=/opt/flask-cicd/venv/bin/python app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "Reloading systemd..."

systemctl daemon-reload

echo "Enabling Flask service..."

systemctl enable flask-cicd

echo "Restarting Flask application..."

systemctl restart flask-cicd

echo "Flask deployment completed!"