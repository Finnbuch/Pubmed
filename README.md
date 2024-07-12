
# Pubmed

The Pubmed repository focuses on preprocessing, organizing, and analyzing articles scraped from the online platform Pubmed/Medline. This repository does not include the scraping process itself but provides tools and scripts for handling the data after it has been scraped.

The repository contains the following files:

Preprocessing_Pipeline.ipynb: This Jupyter notebook contains a pipeline used to filter and clean the data. The preprocessing steps ensure that the articles are in a suitable format for further analysis and storage.

Analysis.ipynb: This Jupyter notebook includes a script for analyzing the sentiment of the texts. It applies sentiment analysis techniques to determine the emotional tone of the articles.

csv_sql_preb: This script prepares the cleaned data into CSV files that can be easily imported into a SQL database.

Abstract_Schema.sql: This SQL script defines the database schema for storing the articles' abstracts and associated metadata. It includes commands to create the necessary tables and structures in the database.

python_sql_api: This script provides an interface for querying the SQL database from within a Python environment. It allows users to retrieve data from the database through specific queries.
