# Hyperparameter Tuning Notebook

## Dual Engine Framework: Hyperparameter Search

This folder contains the hyperparameter tuning notebook used to support the MSc Data Science dissertation project:

**Towards Sustainable 5G Networks: A Dual Engine Framework Using Offline Reinforcement Learning and Surrogate-Based Optimisation**

The notebook implements a light-touch object-oriented workflow for tuning offline reinforcement learning algorithms on historical 5G network data. The selected hyperparameters are later used in the main dual engine framework notebook.

---

## Notebook

```text
hyperparameter_search_v3_OOP.ipynb
```

---

## Purpose of This Notebook

The purpose of this notebook is to identify suitable hyperparameter configurations for the offline reinforcement learning models used in Engine 2 of the dissertation framework.

The notebook compares three offline reinforcement learning algorithms:

- Conservative Q-Learning (CQL)
- Implicit Q-Learning (IQL)
- Twin Delayed Deep Deterministic Policy Gradient with Behaviour Cloning (TD3+BC)

The hyperparameter search is guided by an independent oracle model that estimates the expected energy savings of each candidate policy.

---

## Workflow Summary

The notebook follows the main stages below:

1. **Environment setup and configuration**  
   Defines the required libraries, search configuration, device detection, state variables, action variables, target variable, and plotting palette.

2. **Data engineering and MDP dataset construction**  
   Loads and merges the base station, cell-level, and energy consumption datasets. It then prepares the state, action, and reward structure required for offline reinforcement learning.

3. **Oracle evaluator construction**  
   Builds an independent Random Forest model to act as a digital twin for estimating energy consumption under proposed actions.

4. **Diagnostic visualisation**  
   Produces dataset and search diagnostics, including hourly sample distributions, base station density, optimisation history, and hyperparameter importance.

5. **Bayesian hyperparameter optimisation**  
   Uses Optuna with a TPE-based search strategy to tune CQL, IQL, and TD3+BC.

6. **Result persistence and ranking**  
   Saves the best hyperparameter settings to JSON files and ranks the algorithms according to oracle-predicted energy savings.

7. **Performance diagnostics**  
   Generates visual summaries of convergence, comparative algorithm performance, and parameter sensitivity.

8. **Configuration leaderboard**  
   Prints the top-performing configurations for each algorithm.

---

## Data Requirements

The raw dataset is not included in this repository.

The notebook expects the following files to be available in the working directory or data folder:

```text
BSinfo.csv
CLdata.csv
ECdata.csv
```

These files originate from the Zindi AI/ML for 5G Energy Consumption Modelling competition based on the ITU/Huawei 5G energy consumption modelling challenge.

Users should download the dataset directly from the official Zindi competition page and comply with the applicable terms and conditions.

---

## State, Action, and Target Variables

### State Variables

```text
load
Hour
Frequency
Bandwidth
```

### Action Variables

```text
TXpower
Antennas
ESMode1
ESMode2
ESMode3
ESMode4
ESMode5
ESMode6
```

### Target Variable

```text
Energy
```

The reward is derived from normalised energy consumption, where lower energy use corresponds to a better reward signal.

---

## Hyperparameter Search Setup

The notebook uses a central `SearchConfig` dataclass to control the experiment.

Main settings include:

```text
n_trials = 20 per algorithm
tune_steps = 1000 per trial
n_steps_per_ep = 1000
random_state = 42
```

The notebook automatically detects the available compute device:

```text
cuda
mps
cpu
```

This allows the notebook to run on CUDA-enabled machines, Apple Silicon through MPS, or CPU-only environments.

---

## Algorithms Tuned

### CQL

CQL is tuned using parameters such as:

- Actor learning rate
- Critic learning rate
- Conservative weight

### IQL

IQL is tuned using parameters such as:

- Actor learning rate
- Critic learning rate
- Expectile
- Weight temperature

### TD3+BC

TD3+BC is tuned using parameters such as:

- Actor learning rate
- Critic learning rate
- Alpha
- Batch size

---

## Output Files

The notebook saves the best-performing hyperparameter settings as JSON files.

Expected outputs include:

```text
best_cql_params.json
best_iql_params.json
best_td3_plus_bc_params.json
```

These files are intended to be loaded by the main dual engine framework notebook so that the final model training uses the best configurations found during the search stage.

---

## Evaluation Metric

The main optimisation objective is oracle-estimated energy savings.

The oracle compares:

- Baseline energy consumption from the historical actions
- Predicted energy consumption from the actions proposed by each offline RL agent

The search objective is to maximise the expected percentage reduction in energy consumption.

---

## Reproducibility Notes

To reproduce this notebook:

1. Install the required Python libraries.
2. Download the dataset from the official Zindi competition page.
3. Place the expected CSV files in the correct working directory.
4. Run the notebook from top to bottom.
5. Use the generated JSON files in the main dual engine framework notebook.

Recommended execution order:

```text
1. hyperparameter_search_v3_OOP.ipynb
2. dual_engine_framework.ipynb
```

---

## Main Libraries Used

```text
d3rlpy
optuna
pandas
numpy
torch
scikit-learn
matplotlib
seaborn
```

---

## Dissertation Role

This notebook supports the model selection and tuning stage of the dissertation. It provides the empirical basis for choosing the final offline reinforcement learning configurations used in the main dual engine framework.

The results from this notebook feed directly into the final dissertation analysis by identifying the most promising Engine 2 configurations before the full evaluation stage.

---

## Author

**Mubanga Nsofu**

MSc Data Science  
DS7010 Dissertation Project
