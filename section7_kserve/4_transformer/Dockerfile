FROM python:3.8-slim

COPY requirements.txt .
COPY custom_transformer custom_transformer

RUN pip install --upgrade pip && pip install -r requirements.txt

ENTRYPOINT ["python", "-m", "custom_transformer.transformer"]