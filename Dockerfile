# Stage 1: Build React frontend
FROM node:20-alpine AS frontend-builder

WORKDIR /app
COPY react-test/package*.json ./react-test/
RUN cd react-test && npm install
COPY react-test/ ./react-test
RUN cd react-test && npm run build


# Stage 2: Set up FastAPI backend
FROM python:3.11-slim AS backend

# Set work directory
WORKDIR /app

# Copy backend files
COPY backend/ ./backend/
COPY backend/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy built frontend
COPY --from=frontend-builder /app/react-test/dist ./backend/app/static/

# Optional: expose port
EXPOSE 8000

# Run FastAPI via Gunicorn with Uvicorn workers
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "backend.main:app", "--bind", "0.0.0.0:8000"]

