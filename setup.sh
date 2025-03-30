#!/bin/bash

# Exit on error
set -e

# Update conda and metadata before doing anything
echo "Updating Conda..."
conda update -n base -c defaults conda -y

# Base directory for all environments
ENV_BASE="/home/upGrad-Codepro-Lead-Scoring-MLOps/venv"

# Ensure base directory exists
mkdir -p "$ENV_BASE"

# Function to create Conda env with name and requirements
create_env() {
  local env_name=$1
  local env_path="$ENV_BASE/$env_name"
  local packages=$2

  echo "Creating environment: $env_name"

  # Remove if it already exists
  if conda info --envs | grep -q "$env_path"; then
    echo "Removing existing environment: $env_path"
    conda remove --name "$env_name" --all -y
  fi

  # Create environment
  conda create --prefix "$env_path" -y python=3.8.10 $packages

  # Activate and install Jupyter kernel for notebook access (if Jupyter installed)
  if [[ "$packages" == *"jupyter"* ]]; then
    "$env_path/bin/python" -m ipykernel install --user --name "$env_name" --display-name "$env_name"
  fi
}

# Environment 1: EDA + Profiling
create_env "mlops-eda" "pandas ydata-profiling matplotlib seaborn jupyter"

# Environment 2: Model Experimentation
create_env "mlops-experiment" "pycaret=2.3.10 mlflow=1.30.0 scikit-learn=1.0.2 jupyter"

# Environment 3: Pipelines (Training + Inference)
create_env "mlops-pipeline" "apache-airflow=2.5.3 mlflow=1.30.0 pandas scikit-learn=1.0.2"

# Environment 4: Unit Testing
create_env "mlops-test" "pytest pandas scikit-learn=1.0.2"

echo "All environments created successfully under $ENV_BASE."