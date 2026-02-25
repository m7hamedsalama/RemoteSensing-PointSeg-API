# Using a hidden Python version
FROM python:3.10-slim

# Set the working folder
WORKDIR /app

# Copy all the files from GitHub to this folder
COPY . .

# Installing libraries (PyTorch CPU and others)
RUN pip install --no-cache-dir -r requirements.txt

# Installing libraries (PyTorch CPU and others)
CMD ["python", "app.py"]
