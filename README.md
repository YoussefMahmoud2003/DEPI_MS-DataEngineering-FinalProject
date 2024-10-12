![image](https://github.com/user-attachments/assets/967acb51-5a2b-4497-8a65-927d9e053247)
# DEPI_MS-DataEngineering-FinalProject

This project demonstrates an end-to-end data pipeline implementation using various Azure services. The pipeline involves data ingestion, transformation, and loading to create analytical reports.


## Team Members
- Ahmed Abd El-Mohsen Abd El-Raheem Hussein
- Anas Osama Ali Attya Dorgham
- Marawan Attya Mamdouh 
- Mohammad Shaaban Mustafa abdulhameed
- Youssef Mahmoud Elsayed Abd Elkader


## Project Structure

### Part 1: Environment Setup
- Setting up Azure resources and configuring the environment for data processing.

### Part 2: Data Ingestion
- *Tool*: Azure Data Factory (ADF)
- *Process*: Data ingestion from an on-premise SQL Server database into Azure Data Lake Gen 2 (bronze layer).

### Part 3: Data Transformation
- *Tool*: Azure Databricks
- *Process*: Transforming data across three layers:
  - *Bronze Layer*: Raw ingested data.
  - *Silver Layer*: Cleaned and minimally transformed data (e.g., data type conversions).
  - *Gold Layer*: Final curated data ready for analysis.

### Part 4: Data Loading
- *Tool*: Azure Synapse Analytics
- *Process*: Loading the transformed data into Azure Synapse Analytics for long-term storage and reporting.

### Part 5: Data Reporting
- *Tool*: Power BI
- *Process*: Creating analytical reports based on the transformed and curated data in Azure Synapse.

### Part 6: End-to-End Testing
- Testing the entire pipeline by ingesting new data, performing transformations, and verifying reports.
- This videos shows the testing operation: https://drive.google.com/file/d/1--s9QDi9MFD0ovOjjn_5_-xZrtjHgina/view?usp=drive_link

## Key Tools and Technologies
- *Azure Data Factory*: For orchestrating data ingestion.
- *Azure Synapse Analytics*: For managing the analytics and storage of transformed data.
- *Azure Databricks*: For transforming and processing large datasets.
- *Azure Data Lake Gen 2*: Storage solution for ingested raw data.
- *Power BI*: For creating interactive reports and visualizations.

## Usage Instructions
1. Set up the Azure environment as outlined in the Environment Setup section.
2. Use Azure Data Factory to ingest data from the source (SQL Server) to Azure Data Lake.
3. Use Azure Databricks to process the data through Bronze, Silver, and Gold layers.
4. Load the Gold layer data into Azure Synapse Analytics for reporting.
5. Use Power BI to connect to the Synapse Analytics dataset and create reports.
