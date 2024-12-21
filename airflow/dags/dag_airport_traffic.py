from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.utils.dates import days_ago
import os

# Define the function for the Extract and Transform stage
def extract_transform_data(**kwargs):
    # Read the SQL query from the file
    sql_file_path = '/opt/airflow/include/select_2.sql'
    with open(sql_file_path, 'r') as file:
        select_query = file.read()

    # Connect to the source database
    source_hook = PostgresHook(postgres_conn_id='dwh_dds')
    source_conn = source_hook.get_conn()
    source_cursor = source_conn.cursor()

    # Execute the SELECT query to extract and transform data
    source_cursor.execute(select_query)
    extracted_data = source_cursor.fetchall()

    # Close the connection
    source_cursor.close()
    source_conn.close()

    # Return the extracted data
    return extracted_data

# Define the function for the Load stage
def load_data(**kwargs):
    # Get the extracted data from the previous task
    extracted_data = kwargs['ti'].xcom_pull(task_ids='extract_transform_data')

    # Connect to the target database
    target_hook = PostgresHook(postgres_conn_id='db_analytical')
    target_conn = target_hook.get_conn()
    target_cursor = target_conn.cursor()

    # Create a temporary table to hold the extracted data
    target_cursor.execute("""
        CREATE TEMP TABLE temp_airport_traffic AS
        SELECT * FROM presentation.airport_traffic WHERE false;  -- Create an empty table with the same structure
    """)

    # Insert the extracted data into the temporary table
    insert_temp_query = "INSERT INTO temp_airport_traffic VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    target_cursor.executemany(insert_temp_query, extracted_data)

    # Insert data from the temporary table into the target table
    target_cursor.execute("""
        INSERT INTO presentation.airport_traffic
        SELECT * FROM temp_airport_traffic;
    """)

    # Drop the temporary table
    target_cursor.execute("DROP TABLE temp_airport_traffic;")

    # Commit the changes and close the connection
    target_conn.commit()
    target_cursor.close()
    target_conn.close()

# Define the DAG
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
}

dag = DAG(
    'dag_airport_traffic',
    default_args=default_args,
    description='An ETL DAG to transfer data from source to target DB',
    schedule_interval='@daily',  # Run daily at midnight
)

# Define the tasks
extract_transform_task = PythonOperator(
    task_id='extract_transform_data',
    python_callable=extract_transform_data,
    provide_context=True,
    dag=dag,
)

load_task = PythonOperator(
    task_id='load_data',
    python_callable=load_data,
    provide_context=True,
    dag=dag,
)

# Set task dependencies
extract_transform_task >> load_task