Banking Transaction & Customer Behaviour AnalyticsProject Overview

This project analyzes real-world banking transaction data to uncover customer spending behaviour, financial patterns, and risk indicators. The goal is to generate actionable insights that can support decision-making in banking operations, customer segmentation, and financial risk assessment.

Using SQL and Python, the project explores how customers interact with financial systems, how money flows across categories, and what behavioural patterns emerge from transactional data.

🎯 Objectives
Analyze customer transaction behaviour over time
Identify spending patterns across categories (e.g. food, transport, entertainment)
Segment customers based on financial activity
Detect anomalies and potential risk indicators
Generate business insights for banking decision-making
📁 Dataset

The project uses a real-world inspired banking transactions dataset from Kaggle:

Transactions data (amounts, dates, merchant categories)
Customer information
Account-level activity
Optional fraud/risk indicators (depending on dataset version)

Dataset source: Kaggle Financial Transactions Dataset (ComputingVictor / similar banking datasets)

🛠️ Tech Stack
SQL – Data querying, aggregation, and transformation
Python – Data cleaning, analysis, and visualization
Pandas / NumPy – Data manipulation
Matplotlib / Seaborn – Data visualization
Jupyter Notebook – Exploratory analysis
(Optional) Power BI / Streamlit – Dashboarding
🧠 Key Analysis Performed
1. Customer Spending Behaviour
Monthly spending trends per customer
Category-wise expenditure distribution
Identification of high and low spending users
2. Cash Flow Analysis
Income vs expenses per customer
Savings rate estimation
Detection of overdraft-like behaviour patterns
3. Customer Segmentation

Customers grouped into:

High-value customers (consistent high spending & stable income)
Medium-value customers
High-risk / unstable financial behaviour customers
4. Transaction Pattern Analysis
Peak spending periods (daily/monthly trends)
Frequency of transactions per customer
Volatility in spending behaviour
5. Risk & Anomaly Indicators
Unusual spending spikes
Irregular transaction patterns
High variance in financial activity
📈 Key Insights (Example Outputs)
A small percentage of customers contribute disproportionately to total transaction volume (Pareto effect).
Spending peaks consistently during month-end salary cycles.
Certain customer segments exhibit high financial volatility, indicating potential credit risk.
Transport and food categories dominate monthly expenditure across most users.
📊 Sample Visualizations
Monthly revenue/spending trends
Customer segmentation distribution
Category-wise expenditure breakdown
Transaction frequency heatmaps
📂 Project Structure
banking-transaction-analytics/
│
├── data/
│   └── transactions.csv
│
├── sql/
│   └── queries.sql
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   ├── 02_exploratory_analysis.ipynb
│   ├── 03_insights_generation.ipynb
│
├── visuals/
│   └── charts_and_graphs.png
│
├── README.md
🚀 How to Run This Project
1. Clone the repository
git clone https://github.com/your-username/banking-transaction-analytics.git
2. Install dependencies
pip install pandas numpy matplotlib seaborn jupyter
3. Run notebooks

Open Jupyter Notebook and execute:

01_data_cleaning.ipynb
02_exploratory_analysis.ipynb
03_insights_generation.ipynb
💡 Business Value

This project simulates real banking analytics use cases such as:

Customer segmentation for targeted banking products
Financial behaviour monitoring
Risk profiling for credit decisioning
Transaction trend analysis for strategic planning
👨‍💻 Author

Kgodiso Austin Leboho
Computer Science (MSc Candidate)
Full-Stack Developer | Data & AI Enthusiast

GitHub: github.com/Kgodiso-Leboho
LinkedIn: linkedin.com/in/your-profile
