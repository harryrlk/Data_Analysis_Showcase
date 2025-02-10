
# Brief Report on OpportunityWW Dataset Analysis

## Overview
This report summarizes the analysis of the "OpportunityWW.xlsx" dataset, which contains information about sales opportunities. The primary objective was to clean the data, engineer relevant features, and build predictive models to assess the likelihood of sales outcomes. The analysis utilized logistic regression for classification and linear regression for understanding relationships between variables.

## Key Steps

1. **Data Import and Initial Exploration**:
   - Imported the dataset using pandas and examined the first few rows.
   - Summarized the dataset shape and information, revealing 1,577 entries and 14 columns.

2. **Data Cleaning**:
   - Identified and handled missing values, particularly in columns like "Amount" and "Licenses Quoted."
   - Dropped columns with more than 10% missing values and unnecessary columns, reducing the dataset to 7 key variables.
   - Created a new column, "Duration," to measure the difference in days between "Created Date" and "Close Date."

3. **Feature Engineering**:
   - Categorical variables such as "Stage," "Opportunity Owner," "Lead Source," and "Territory" were label-encoded for modeling purposes.

4. **Modeling**:
   - **Logistic Regression**:
     - Split the dataset into training and test sets.
     - Achieved an accuracy of **82.89%**, precision of **78.66%**, recall of **92.81%**, and an F1 score of **0.85**.
     - Evaluated performance using a confusion matrix and ROC curve.
   - **Linear Regression**:
     - Analyzed the relationship between features and the target variable.
     - Achieved an R-squared value of **0.373**.

5. **Feature Importance Analysis**:
   - Identified the most influential variables in both logistic and linear regression models.

## Results
- The logistic regression model demonstrated strong predictive capabilities, particularly in recall, indicating a good ability to identify "Closed Won" opportunities.
- The linear regression model provided insights into the relationships between features and sales outcomes, though with a moderate explanatory power (R-squared of 0.373).

## Conclusion
The analysis of the "OpportunityWW" dataset successfully highlighted key factors influencing sales outcomes through effective data cleaning, feature engineering, and modeling. The logistic regression model proved to be a robust tool for predicting sales success, while the linear regression analysis offered valuable insights into the relationships among variables. Future work could focus on refining the models and exploring additional features to enhance predictive accuracy.
