# Python Projects

This folder contains Python-based data analysis and machine learning projects, primarily implemented using Jupyter Notebooks. The projects demonstrate end-to-end workflows including data cleaning, exploratory data analysis (EDA), feature engineering, modeling, evaluation, and business insights.

Tools & Libraries Used:
- **pandas**, **numpy** – Data manipulation and analysis
- **matplotlib**, **seaborn** – Data visualization
- **scikit-learn** – Machine learning models, preprocessing, and evaluation metrics
- **Jupyter Notebook** – Interactive analysis and reporting

## Featured Projects

### 1. Airline Passenger Satisfaction Analysis
**Dataset**: Public airline passenger satisfaction survey (features include demographics, flight experience, service ratings, etc.)  
**Objective**: Predict passenger satisfaction ("satisfied" vs. "neutral or dissatisfied") using classification models.

**Key Highlights**:
- Comprehensive data cleaning and categorical encoding
- In-depth EDA with visualizations of feature distributions and relationships
- Built and compared **Logistic Regression** and **Decision Tree** models
- Model evaluation using accuracy, precision, recall, F1-score, confusion matrix, and ROC curves

**Results**:
- Logistic Regression: **86.33%** accuracy (Precision 85.91%, Recall 82.19%, F1 0.84)
- Optimized Decision Tree (max depth 11): **94.42%** accuracy

**Business Value**: Identified key drivers of passenger satisfaction, providing actionable insights for airlines to improve service quality and customer experience.

[View Notebook](./Airline%20Passenger%20Satisfaction%20Analysis/Airline_Passenger_Satisfaction_Analysis.ipynb)  
*(Add screenshots of key visualizations and model results in an `images/` folder for quick preview)*

### 2. OpportunityWW Sales Opportunity Analysis
**Dataset**: Internal sales opportunity data ("OpportunityWW.xlsx") with 1,577 records and 14 initial columns  
**Objective**: Predict sales outcome ("Closed Won" vs. others) and understand factors influencing opportunity success.

**Key Highlights**:
- Thorough data cleaning: handled missing values, dropped low-value columns, reduced to 7 key variables
- Feature engineering: created "Duration" (days between Created Date and Close Date), label-encoded categorical variables
- Built **Logistic Regression** for classification and **Linear Regression** for relationship analysis
- Comprehensive model evaluation including confusion matrix, ROC curve, and feature importance

**Results**:
- Logistic Regression: **82.89%** accuracy (Precision 78.66%, Recall 92.81%, F1 0.85) – strong at identifying "Closed Won" opportunities
- Linear Regression: R² = **0.373** (moderate explanatory power)

**Business Value**: Revealed influential factors in sales success, enabling sales teams to prioritize high-potential opportunities and improve win rates.

[View Notebook](./OpportunityWW%20Dataset%20Analysis/OpportunityWW_Analysis.ipynb)  
*(Add screenshots of EDA plots, confusion matrix, ROC curve, and feature importance in an `images/` folder)*

These projects showcase practical application of Python for solving real-world business problems in customer experience and sales forecasting. Feel free to explore the notebooks for detailed code, commentary, and visualizations.

Suggestions for further improvement:
- Add interactive dashboards (e.g., using Plotly or Streamlit)
- Experiment with additional models (Random Forest, XGBoost)
- Deploy models via simple web apps for greater impact
