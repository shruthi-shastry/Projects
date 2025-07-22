'''
Name : Shruthi Shashidhara Shastry
Student Id : 33684669
Last modified date:20-10-2023
Description :This file contains DataVisualizer class ,its attribute and instance methods
    '''

# Import necessary libraries and classes
import pandas as pd
import matplotlib.pyplot as plt
from DataExtraction import DataExtraction

class DataVisualizer:
    """
             A class used for visualisating a given dataset (e.g: histogram,line graph)

            Attribute:
                dataframe : The csv dataset to be visualised.

             methods:
                --prop_val_distribution(property_data , suburb, target_currency="AUD"):
                    Produces a graphical representation (histogram) of property values' distribution for specified suburb or all suburbs.
                -- sales_trend(property_data):
                        Produces a line graph representing the sales trend over the years (from 2010 to 2023).
        """

    def __init__(self, dataframe):
        '''
            Constructor to initialize the class instance with a DataFrame containing property data.

            Instance variable:
            - dataframe (pandas.DataFrame): The DataFrame containing property data.
        '''
        # Constructor to initialize the class with the dataset
        self.property_data = dataframe

    def prop_val_distribution(self, property_data, suburb, target_currency="AUD"):
        '''Method Description :
              Produces a histogram of property values distribution.

        Parameters:
                 -property_data(pandas.Dataframe): The csv dataset.
                 - suburb(str): The suburb to analyze.
                 - target_currency(str eg: AUD): The currency to convert property values to (default is AUD).

        Returns : None
        '''
        # check is dataframe is empty or not
        if property_data is None:
            print("\nError!! data not loaded")
            return

        column_to_check = 'suburb'
        # check if the suburb column exists
        if column_to_check in property_data.columns:
            # defining the currency dict
            currency_dict = {
                "AUD": 1,
                "USD": 0.66,
                "INR": 54.25,
                "CNY": 4.72,
                "JPY": 93.87,
                "HKD": 5.12,
                "KRW": 860.92,
                "GBP": 0.51,
                "EUR": 0.60,
                "SGD": 0.88
            }
            # Check if the target currency is in the dictionary, use AUD by default, if not found
            if target_currency not in currency_dict:
                print(f"\ncurrency '{target_currency}' not found in the currency dictionary. Using AUD by default.")
                target_currency = "AUD"

            # Check if the specified suburb exists in the dataset
            if suburb != "all" and suburb not in property_data['suburb'].str.lower().values:
                print(f"\nSuburb '{suburb}' not found.\nShowing histogram graph for all suburbs")
                suburb = "all"

            # Create an instance of Extraction
            extract = DataExtraction()

            if suburb != "all":
                # Filter data for the specified suburb
                selected_data = property_data[property_data['suburb'].str.lower() == suburb]
                # Convert property values to the target currency
                exchange_rate = currency_dict[target_currency]
                data_in_target_currency = extract.currency_exchange(selected_data, exchange_rate)

            else:
                # Convert property values to the target currency for all suburbs
                exchange_rate = currency_dict[target_currency]
                # Invoking the currency_exchange method to convert property values
                data_in_target_currency = extract.currency_exchange(property_data, exchange_rate)

            if data_in_target_currency is not None:
                # Convert data to millions for plotting
                data_to_plot_in_target_currency = [x / 1000000 for x in data_in_target_currency]

                # Create a histogram of property values
                plt.hist(data_to_plot_in_target_currency, bins=40, color='green')
                plt.title(f'Property Value Distribution in {suburb} suburb')
                plt.xlabel(f'Property Value ({target_currency}), in million')
                plt.ylabel('Frequency')

                # Save the histogram as an image file
                filename = f'property_value_distribution_{suburb}.png'
                plt.savefig(filename)
                print(f"\nThe image of the histogram successfully stored in your local as {filename} in this same directory")
            else:
                print("\ncurrency exchange is not possible please check the the dataset,exchange_rate etc")
                return

        else:
            print("\nThe column suburb is not present in the dataset ")
            return
    def sales_trend(self, property_data):
        '''Method Description :
            Produces a line graph representing sales trends over the years.

            Parameter:
                - property_data(pandas.Dataframe): The dataset.

            Returns : None
        '''
        if property_data is None:
            print("Error!! data not loaded")
            return

        column_to_check = 'sold_date'

        # check if the sold_date column exists
        if column_to_check in property_data.columns:

            try:
                # Convert 'sold_date' to datetime format
                property_data['sold_date'] = pd.to_datetime(property_data['sold_date'], format='%d/%m/%Y')
                property_data['Year'] = property_data['sold_date'].dt.year
            except ValueError:
                print("Error: Unable to convert 'sold_date' to datetime. Please check the date format.")
                return

            # Filter out rows with missing 'Year' values
            filtered_data = property_data.dropna(subset=['Year'])

            # Calculate the number of properties sold in each year
            if not filtered_data.empty:
                sales_by_year = {}
                for year in filtered_data['Year']:
                    if year in sales_by_year:
                        sales_by_year[year] += 1
                    else:
                        sales_by_year[year] = 1
            else:
                print("no valid years present to plot line graph")
                return

            years = list(sales_by_year.keys())
            sold_no = [sales_by_year[year] for year in years]

            try:
                # Create a line graph to show sales trend
                plt.figure(figsize=(10, 6))
                plt.plot(years, sold_no, marker='o', linestyle='-', color='g')
                plt.title('Sales Trend from 2010 to 2023')
                plt.xlabel('Year')
                plt.ylabel('Number of Properties Sold')
                plt.savefig('sales_trend_chart.png')
                print("The image of the line graph was successfully stored in your local as sales_trend_chart.png in this same directory ")
            except (ValueError, FileNotFoundError):
                print("Error: Unable to create or save the line chart image.")
                return

        else:
            print("\nThe column sold_date is not present in the dataset ")
            return


