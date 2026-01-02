# R Projects

This folder contains R-based data analysis and machine learning projects, implemented using R scripts and R Markdown for reproducible workflows. These projects highlight skills in data cleaning, exploratory data analysis (EDA), statistical testing, advanced visualization, time-series analysis, sequential pattern mining, and machine learning.

Tools & Libraries Used:
- **tidyverse** (dplyr, ggplot2, tidyr, etc.) – Data manipulation and visualization
- **TraMineR** – Sequence analysis and sequential pattern mining
- **rpart**, **randomForest**, **e1071** – Machine learning models
- **pROC**, **caret** – Model evaluation
- **cluster** – Clustering techniques

## Featured Projects

### 1. Pokémon Legendary Classification (Practice Project)
**Dataset**: Public Pokémon dataset with attributes (HP, Attack, Defense, Sp. Atk, Sp. Def, Speed, Type, Generation, etc.)  
**Objective**: Predict whether a Pokémon is "Legendary" using classification models; comprehensive end-to-end practice project.

**Key Highlights**:
- Data cleaning and preparation (handling missing values, type conversion)
- In-depth EDA with bar plots, histograms, correlation matrices, and custom visualizations
- Statistical testing using Chi-Square tests for attribute relationships
- Machine learning: Decision Tree, Random Forest, and Support Vector Machine (SVM) models
- Model evaluation with confusion matrices and ROC curves
- Unsupervised learning: k-means clustering for Pokémon segmentation

**Business/Academic Value**: Demonstrates a complete data science workflow from raw data to predictive modeling and clustering in a fun, accessible domain.


### 2. SKU Purchase Analysis and Sequential Pattern Mining **(Main Highlight)**
**Dataset**: Internal merchant purchase records (SKU-level transactions with date, price, merchant ID, etc.)  
**Objective**: Uncover recurring SKU purchase patterns and behaviors across merchants using sequence analysis and visualization.

**Key Highlights**:
- Thorough data cleaning and merchant-specific filtering (focused on Merchant IDs 1607, 1477, 1196)
- Comprehensive EDA with histograms, boxplots, scatterplots, and time-series visualizations using ggplot2
- **Sequential pattern mining** with TraMineR: created sequence objects and generated **seqiplot** visualizations of most common SKU purchase sequences
- Time-series price and purchase volume analysis with daily bar plots
- Clustering of purchase sequences using k-means and calculation of Hamming (HAM) distance for sequence similarity

**Business Value**: Revealed actionable insights into merchant purchasing behavior, such as frequently co-purchased SKUs and recurring sequences. These findings can support inventory planning, supplier negotiation, and demand forecasting in retail/supply chain contexts.


These R projects showcase advanced analytical techniques beyond standard reporting, particularly in sequential pattern mining – a valuable skill in retail, e-commerce, and customer behavior analysis.

Future enhancements could include:
- Interactive dashboards with Shiny
- More advanced sequence mining (e.g., frequent subsequence mining with arulesSequences)
- Integration with forecasting models for SKU demand

Feel free to explore the scripts for detailed code and commentary.
