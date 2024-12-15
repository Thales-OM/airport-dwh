from kafka import KafkaConsumer
import json

# Kafka configuration
kafka_bootstrap_servers = 'localhost:29092'  # Change to your Kafka server
kafka_topic = 'my_connect_configs'  # Replace with your topic name

# Create Kafka consumer
consumer = KafkaConsumer(
    kafka_topic,
    bootstrap_servers=kafka_bootstrap_servers,
    auto_offset_reset='earliest',  # Start reading at the earliest message
    enable_auto_commit=True,
    value_deserializer=lambda x: json.loads(x.decode('utf-8'))  # Deserialize JSON messages
)

# Consume messages
try:
    for message in consumer:
        print(f"Received message: {message.value}")
except KeyboardInterrupt:
    print("Stopping consumer...")
finally:
    consumer.close()