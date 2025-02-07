## SKU Purchase Analysis and Sequential Plot

In this R project, I analyze a dataset containing purchase information from various merchants, focusing on exploring SKU purchase patterns. The analysis covers several aspects, including **data cleaning**, **exploratory data analysis (EDA)**, and **sequential plot visualization**.

### Data Cleaning & Exploration
The dataset is read and cleaned, with missing values checked for important columns like `sku_id`, `date`, and `price`. Summary statistics and the structure of the dataset are explored to better understand the data. I then filter the dataset to analyze individual merchants (Merchant IDs: 1607, 1477, and 1196) and examine their unique purchase behaviors.

### Exploratory Data Analysis (EDA)
I create histograms and boxplots for `order_id`, `price`, and other relevant columns to visualize the distribution of data for different merchants. Scatterplots are used to explore relationships between `price` and `date` for individual merchants.

### Sequential Plot
Using the `TraMinR` package, I create a **Sequential Plot** to visualize the most common purchase sequences of SKUs across merchants. The dataset is filtered to focus on a subset of SKUs, and sequences of purchases are plotted using `seqiplot`. This visualization helps reveal recurring patterns, such as certain SKUs being purchased together in specific sequences.

### Time-Series & Price Visualization
I plot time-series data to show how the prices change over time for specific merchants. This is done using `ggplot2` to create bar plots of daily prices and SKU purchases for selected merchants.

### Sequential Pattern Analysis
The sequential patterns are further analyzed using **clustering** methods. Using `kmeans`, I group purchase sequences into clusters, revealing common purchase behaviors. Additionally, I calculate the **HAM distance** between different sequences to understand the similarity between them.

The analysis provides insights into SKU purchasing behavior, identifying common patterns and trends in merchant purchase sequences.
