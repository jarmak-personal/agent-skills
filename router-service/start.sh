#!/bin/bash
# Start the Agent Router Service

cd "$(dirname "$0")"

# Use project venv if available, otherwise fall back to system Python
if [ -d ".venv" ]; then
    source .venv/bin/activate
fi

# Determine Python interpreter
if command -v python3 >/dev/null 2>&1; then
    PYTHON=python3
else
    PYTHON=python
fi

# Check if dependencies are installed
if ! "$PYTHON" -c "import fastapi, uvicorn, pydantic" 2>/dev/null; then
    echo "Installing dependencies..."
    "$PYTHON" -m pip install -r requirements.txt
fi

echo "Starting Agent Router Service on http://127.0.0.1:8765"
echo "API docs available at http://127.0.0.1:8765/docs"
echo ""

"$PYTHON" -m uvicorn router:app --host 127.0.0.1 --port 8765
