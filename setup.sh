#!/bin/bash

# Check if conda is available; install Miniconda if not
if ! command -v conda &> /dev/null; then
  echo "Conda not found. Installing Miniconda..."
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
  bash miniconda.sh -b -p $HOME/miniconda
  source "$HOME/miniconda/etc/profile.d/conda.sh"
  conda init
  echo "Miniconda installed. Please restart your shell or run 'source ~/.bashrc' before proceeding."
  exit 0
fi

# Exit on error
set -e

# Base directory for all environments
ENV_BASE="/home/upGrad-Codepro-Lead-Scoring-MLOps/venv"

# Ensure base directory exists
mkdir -p "$ENV_BASE"

# Function to create Conda env with name and requirements
create_env() {
  local env_name=$1
  local env_path="$ENV_BASE/$env_name"
  local packages=$2
  local pip_packages=$3

  echo "Creating environment: $env_name"

  # Remove if it already exists
  if conda info --envs | grep -q "$env_path"; then
    echo "Removing existing environment: $env_path"
    conda remove --prefix "$env_path" --all -y
  fi

  # Create environment using conda-forge for broader package availability
  conda create -y -c conda-forge --prefix "$env_path" python=3.8.10 $packages

  # Activate pip-based installs (for packages not on conda)
  if [[ ! -z "$pip_packages" ]]; then
    "$env_path/bin/pip" install --no-cache-dir $pip_packages
  fi

  # Register Jupyter kernel if Jupyter is in conda packages
  if [[ "$packages" == *"jupyter"* ]]; then
    "$env_path/bin/python" -m ipykernel install --user --name "$env_name" --display-name "$env_name"
  fi
}

# Environment 1: EDA + Profiling (ydata-profiling via pip)
create_env "mlops-eda" "pandas matplotlib seaborn jupyter" "ydata-profiling"
ln -sf /home/upGrad-Codepro-Lead-Scoring-MLOps/venv/mlops-eda ~/miniconda/envs/mlops-eda

# Environment 2: Model Experimentation
create_env "mlops-experiment" "scipy=1.7.3 numpy=1.21.4 pandas=1.3.3 pycaret=2.3.10 mlflow=1.30.0 pydantic=1.10.8 jupyter" "databricks-cli==0.17.3 pandas-profiling==3.1.0 jinja2<3.1"
ln -sf /home/upGrad-Codepro-Lead-Scoring-MLOps/venv/mlops-experiment ~/miniconda/envs/mlops-experiment

# Environment 3: Pipelines (Training + Inference, Airflow via pip)
create_env "mlops-pipeline" "mlflow=1.30.0 pandas scikit-learn=1.0.2" "apache-airflow==2.5.3"
ln -sf /home/upGrad-Codepro-Lead-Scoring-MLOps/venv/mlops-pipeline ~/miniconda/envs/mlops-pipeline

# Environment 4: Unit Testing
create_env "mlops-test" "pandas=1.5.3 scikit-learn=0.23.2 pytest" ""
ln -sf /home/upGrad-Codepro-Lead-Scoring-MLOps/venv/mlops-test ~/miniconda/envs/mlops-test

echo "All environments created successfully under $ENV_BASE."

