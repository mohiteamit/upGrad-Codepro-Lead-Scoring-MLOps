# test_mlops_experiment.py
# Purpose: Test PyCaret 2.3.10 and MLflow 1.30.0 using a classification task with GPU and logging

from pycaret.datasets import get_data
from pycaret.classification import *
import mlflow
import mlflow.sklearn
import os

# Set MLflow tracking URI to local file-based store
mlflow.set_tracking_uri("file:./mlruns")
mlflow.set_experiment("pycaret-iris-classification")

# Load dataset
print("Loading dataset...")
data = get_data("iris")

# Set up PyCaret classification experiment
print("Setting up PyCaret experiment with GPU support and logging...")
exp = setup(
    data=data,
    target="species",
    session_id=123,
    use_gpu=True,  # enable GPU where supported (e.g., XGBoost, LightGBM)
    log_experiment=True,
    experiment_name="pycaret-iris-classification",
    log_plots=True,
    log_profile=True,
    log_data=True,
    silent=True,
    verbose=True
)

# Compare models and select the best one
print("Training models and selecting the best one...")
best_model = compare_models()

# Finalize and log the best model manually as well
print("Finalizing and logging best model to MLflow...")
best_model_final = finalize_model(best_model)

with mlflow.start_run(run_name="best_model_run"):
    mlflow.sklearn.log_model(best_model_final, "model")
    mlflow.log_param("model_type", str(best_model))
    mlflow.log_params(get_config("setup_config"))  # log all setup config
    mlflow.log_metric("Accuracy", pull().iloc[0]['Accuracy'])  # log main metric manually

print("✅ Test completed. Model and metrics logged to MLflow.")
