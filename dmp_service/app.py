import json
import uuid
import psycopg2
import os
from kafka import KafkaConsumer

# Настройки Kafka
KAFKA_BOOTSTRAP_SERVERS = os.getenv('KAFKA_BROKERCONNECT', 'kafka:9092')

# Настройки базы данных
DB_SETTINGS = {
    "dbname": os.getenv('POSTGRES_DB', 'postgres'),
    "user": os.getenv('POSTGRES_USER', 'postgres'),
    "password": os.getenv('POSTGRES_PASSWORD', 'postgres'),
    "host": os.getenv('POSTGRES_HOST', 'dwh_dds'),
    "port": int(os.getenv('POSTGRES_PORT', '5432')),
}
TARGET_DDS_SCHEMA = os.getenv('TARGET_DDS_SCHEMA')

# Функция для обработки сообщений
def process_message(message):
    try:
        data = json.loads(message.value)
        operation = data["operation"]
        record = data["data"]
        table = message.topic  # Use the topic name as the table name
        schema = TARGET_DDS_SCHEMA

        if operation == "INSERT":
            if table.startswith("Hub_"):
                process_hub(schema, table, record)
            elif table.startswith("Link_"):
                process_link(schema, table, record)
            elif table.startswith("Sat_"):
                process_satellite(schema, table, record)
        elif operation == "UPDATE":
            # Handle updates if necessary
            handle_update(schema, table, record)
        elif operation == "DELETE":
            # Handle deletes if necessary
            handle_delete(schema, table, record)

    except Exception as e:
        print(f"Error processing message: {e}")

# Обработка вставки данных в Hub
def process_hub(schema, table, record):
    hash_key = str(uuid.uuid5(uuid.NAMESPACE_DNS, record["Airport_Code"]))
    record["Airport_HK"] = hash_key

    insert_query = f"""
        INSERT INTO {schema}.{table} (Airport_HK, Airport_Code, Load_DTS, Record_Source)
        VALUES (%(Airport_HK)s, %(Airport_Code)s, %(Load_DTS)s, %(Record_Source)s)
        ON CONFLICT (Airport_HK) DO NOTHING;
    """
    execute_query(insert_query, record)

# Обработка вставки данных в Link
def process_link(schema, table, record):
    link_key = str(uuid.uuid4())  # Генерируем уникальный ключ для линка
    record["Link_HK"] = link_key

    insert_query = f"""
        INSERT INTO {schema}.{table} (Link_HK, Flight_HK, Departure_Airport_HK, Arrival_Airport_HK, Load_DTS, Record_Source)
        VALUES (%(Link_HK)s, %(Flight_HK)s, %(Departure_Airport_HK)s, %(Arrival_Airport_HK)s, %(Load_DTS)s, %(Record_Source)s)
        ON CONFLICT (Link_HK) DO NOTHING;
    """
    execute_query(insert_query, record)

# Обработка вставки данных в Satellite
def process_satellite(schema, table, record):
    insert_query = f"""
        INSERT INTO {schema}.{table} (Airport_HK, Airport_Name, City, Coordinates_Lon, Coordinates_Lat, Timezone, Load_DTS, Record_Source, Effective_From, Effective_To)
        VALUES (%(Airport_HK)s, %(Airport_Name)s, %(City)s, %(Coordinates_Lon)s, %(Coordinates_Lat)s, %(Timezone)s, %(Load_DTS)s, %(Record_Source)s, %(Effective_From)s, %(Effective_To)s)
        ON CONFLICT (Airport_HK) DO NOTHING;
    """
    execute_query(insert_query, record)

# Функция для обработки обновлений
def handle_update(schema, table, record):
    # Implement update logic if needed
    pass

# Функция для обработки удалений
def handle_delete(schema, table, record):
    # Implement delete logic if needed
    pass

# Функция для выполнения запросов к базе
def execute_query(query, params):
    try:
        conn = psycopg2.connect(**DB_SETTINGS)
        cursor = conn.cursor()
        cursor.execute(query, params)
        conn.commit()
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Database error: {e}")

# Основной потребитель Kafka
def run_consumer():
    # Subscribe to all topics that match the pattern db_pg_master.public.*
    consumer = KafkaConsumer(
        bootstrap_servers=KAFKA_BOOTSTRAP_SERVERS,
        value_deserializer=lambda v: json.loads(v.decode("utf-8")),
        auto_offset_reset='earliest',
        enable_auto_commit=True
    )

    # Get the list of topics dynamically if needed
    consumer.subscribe(pattern='^db_pg_master\\.public\\..*')

    for message in consumer:
        process_message(message)

if __name__ == "__main__":
    run_consumer()