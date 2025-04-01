# upGrad-Codepro-Lead-Scoring-MLOps

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh 
source ~/.bashrc


---
# To remove virtual enviorenment and re-install
# Use constrain for airflow 

conda deactivate
conda remove --name mlops-pipeline --all
conda create --name mlops-pipeline python=3.10
conda activate mlops-pipeline
pip install apache-airflow[password]==2.7.3 --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.7.3/constraints-3.10.txt"


conda deactivate
conda env create -f mlops-eda/environment.yml
python -m ipykernel install --user --name=mlops-eda
python -m ipykernel install --user --name=mlops-experiment

-----

mlflow ui --port=5001 --host=0.0.0.0

---

airflow db migrate

airflow users create \
    --username admin \
    --password admin \
    --firstname Peter \
    --lastname Parker \
    --role Admin \
    --email mohite.amit@gmail.com

airflow webserver --port 8080

airflow scheduler
