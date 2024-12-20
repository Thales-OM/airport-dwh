from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
import pandas as pd
import psycopg2

def extract():
    conn = psycopg2.connect("dbname='dwh_dds' user='admin' password='admin' host='postgres_dwh'")
    query = "SELECT * FROM your_table"  # Replace with your actual table name
    df = pd.read_sql(query, conn)
    conn.close()
    df.to_csv('/opt/airflow/data/raw_data.csv', index=False)

def transform():
    df = pd.read_csv('/opt/airflow/data/raw_data.csv')
    # Perform your transformation logic here
    df['new_column'] = df['existing_column'] * 2  # Example transformation
    df.to_csv('/opt/airflow/data/cleaned_data.csv', index=False)

def load():
    conn = psycopg2.connect("dbname='db_analytical' user='admin' password='admin' host='postgres_analytical'")
    df = pd.read_csv('/opt/airflow/data/cleaned_data.csv')
    df.to_sql('your_new_table', conn, if_exists='replace', index=False)  # Replace with your actual table name
    conn.close()

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 12, 1),
    'retries': 3,
    'retry_delay': timedelta(minutes=1),
}

dag = DAG('etl_dag', default_args=default_args, schedule_interval='@daily')

extract_task = PythonOperator(task_id='extract', python_callable=extract, dag=dag)
transform_task = PythonOperator(task_id='transform', python_callable=transform, dag=dag)
load_task = PythonOperator(task_id='load', python_callable=load, dag=dag)

extract_task >> transform_task >> load_task