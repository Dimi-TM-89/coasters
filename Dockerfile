# Step 1: Use Python 3.12 image as the base image
FROM python:3.12

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy and install dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Step 4: Copy the entire project structure
COPY . .

# Step 5: Inform Docker that the container listens on port 80
EXPOSE 80

# Step 6: Start FastAPI via uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]

