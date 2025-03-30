# upGrad-Codepro-Lead-Scoring-MLOps

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh 

<!-- conda create -n mlops python=3.10.8 -c conda-forge
conda create --name test-env   python=3.10.8   numpy   pandas   scipy   pandas-profiling   pycaret  mlflow airflow   scikit-learn   --channel conda-forge   --dry-run > log.txt
conda update -n base -c defaults conda -->

-- Following does not work
<!-- conda create --name mlops \
  python=3.10.8 \
  numpy \
  pandas \
  scipy \
  ydata-profiling=4.16.0 \
  pycaret \
  mlflow \
  airflow \
  scikit-learn=1.2.2 \
  --channel conda-forge -->

-- Following does not work
<!-- conda create --name mlops \
  python \
  numpy \
  pandas \
  scipy \
  ydata-profiling \
  pycaret \
  mlflow \
  airflow \
  scikit-learn \
  --channel conda-forge -->

# By ChatGPT research 

# Using one-liner conda install
conda create -y -n mlops python=3.10
conda activate mlops
conda config --env --add channels conda-forge
conda config --env --set channel_priority strict
conda install -y pycaret=3.3.2 mlflow=2.21.2 ydata-profiling=4.16.1 airflow=2.10.5 jupyterlab=3.6.5 ipykernel ipywidgets


conda install -y pycaret=3.3.2 mlflow=2.21.2 airflow=2.10.5 jupyterlab=3.6.5 ipykernel ipywidgets
