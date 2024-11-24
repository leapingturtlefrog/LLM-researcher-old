FROM python:3.11-slim
# Set environment variables
# ENV VAR=EXAMPLE
WORKDIR /usr
# Install dependencies
# RUN apt-get update && apt-get install -y example-package
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "-m", "src.__main__"]
