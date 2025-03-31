import os
import subprocess
import time
from pathlib import Path

# Set AIRFLOW_HOME (optional, but good practice)
AIRFLOW_HOME = str(Path.home() / "airflow")
os.environ["AIRFLOW_HOME"] = AIRFLOW_HOME

# 1. Initialize Airflow DB
subprocess.run(["airflow", "db", "migrate"], check=True)

# 2. Create admin user (will skip if already exists)
print("\nCreating admin user (ignore if it says 'user already exists')...\n")
subprocess.run([
    "airflow", "users", "create",
    "--username", "admin",
    "--password", "admin",
    "--firstname", "air",
    "--lastname", "flow",
    "--role", "Admin",
    "--email", "admin@example.com"
], check=True)

# 3. Create a simple test DAG
dags_folder = Path(AIRFLOW_HOME) / "dags"
dags_folder.mkdir(parents=True, exist_ok=True)
dag_file = dags_folder / "test_dag.py"

dag_code = '''
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def hello():
    print("✅ Airflow DAG is working!")

with DAG(
    dag_id="test_hello_dag",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["test"],
) as dag:
    task = PythonOperator(
        task_id="say_hello",
        python_callable=hello
    )
'''

dag_file.write_text(dag_code)
print(f"\n✅ Test DAG created at: {dag_file}\n")

# 4. Start scheduler (in background)
print("🔄 Starting Airflow scheduler in background...")
subprocess.Popen(["airflow", "scheduler"])

# 5. Start webserver (in foreground, port 8080)
print("🌐 Starting Airflow webserver at http://localhost:8080 ...")
print("Login with username: admin | password: admin\n")
time.sleep(3)
subprocess.run(["airflow", "webserver", "--port", "8080"])
