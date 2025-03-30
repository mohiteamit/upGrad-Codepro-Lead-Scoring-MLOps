# test_mlops_experiment.py
# Purpose: Test PyCaret 2.3.10 and MLflow 1.30.0 using a classification task with GPU and logging

from pycaret.classification import *
import mlflow
import mlflow.sklearn
import os

# Set MLflow tracking URI to local file-based store
mlflow.set_tracking_uri("file:./mlruns")
mlflow.set_experiment("pycaret-iris-classification")

# Load dataset
data = pd.read_csv('./notebooks/data/cleaned_data.csv')

# Set up PyCaret classification experiment
print("Setting up PyCaret experiment with GPU support and logging...")
exp = setup(
    data=data,
    target = 'app_complete_flag',  
    fold_shuffle=True, 
    session_id = 42,
    normalize = True, 
    transformation = True, 
    remove_multicollinearity = True, 
    multicollinearity_threshold = 0.95,
    n_jobs=-1,
    use_gpu=False,
    log_experiment=True,
    experiment_name='Lead_Scoring_Model_Experimentation',
    log_plots=True,
    log_data=True,
    silent=True, 
    verbose=True,
    log_profile=False
)

# Compare models and select the best one
print("Training models and selecting the best one...")
best_model = compare_models(fold = 5,exclude=['lightgbm', 'gbc','knn','qda', 'dummy', 'svm', 'ada'])

# Finalize and log the best model manually as well
print("Finalizing and logging best model to MLflow...")
best_model_final = finalize_model(best_model)

print("✅ Test completed. Model and metrics logged to MLflow.")
