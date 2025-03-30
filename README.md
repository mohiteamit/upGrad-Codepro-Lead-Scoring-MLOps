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
conda create --name mlops python=3.9
conda activate mlops
conda config --add channels conda-forge
conda config --set channel_priority strict
conda install ydata-profiling=4.16.0 pycaret=3.0.2 mlflow=2.5.0 airflow=2.5.0 scikit-learn=0.24.2
python -m ipykernel install --user --name=mlops
conda env export --name mlops > mlops_env.yml


conda env create -f mlops_env.yml
