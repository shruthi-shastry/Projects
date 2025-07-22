'''
Name : Shruthi Shashidhara Shastry
Student Id : 33684669
Last modified date: 20-10-2023
Description :This file contains Extraction class and its instance method
    '''

#Import statements
import pandas as pd
import numpy as np
import os

class DataExtraction:
    """
             A class used for extraction of data (in this case csv dataset)

              Attribute:
                    None

             methods:
                -extract_property_info(file_path):
                    method is responsible for reading the property information from the csv file loacted at the specified file path
        """

    def __init__(self):
        pass

    def extract_property_info(self, file_path):
        '''Method Description: Extract property information from a CSV file.

                Parameters:
                    - file_path (str): The path to the CSV file.

                Returns:
                    - DataFrame: A Pandas DataFrame containing the property information from the CSV file, or None if there is an error.
                '''
        try:
            # Check if the file exists and is a valid file
            if(os.path.exists(file_path) and os.path.isfile(file_path)):
            # Read the CSV file into a DataFrame
                dataframe = pd.read_csv(file_path)
                if dataframe is not None and dataframe.isna().all().all():
                    print("Error !! Dataset not loaded please load it!! ")
                    return None
                else:
                    return dataframe
            else:
                print("\nFile does not exists please upload the csv file")
                return None
        except FileNotFoundError:
            print("FileNotFoundError: The file does not exist.")
            return None
        except Exception as e:
            print(f"An error occurred: {str(e)}")
            return None

    def currency_exchange(self, dataframe, exchange_rate):
        '''
               Convert property prices in the DataFrame to the target currency.

               Parameters:
                   - dataframe (pandas.DataFrame): The DataFrame containing property prices.
                   - exchange_rate (float): The exchange rate to use for conversion.

               Returns:
                   - numpy array: An array of converted property prices.
               '''

        if dataframe is None:
            print("Error!! data not loaded")
            return None

        if exchange_rate <= 0:
            print("Error: Invalid exchange rate.")
            return None

        column_to_check = 'price'
        # check if the suburb column exists
        if column_to_check in dataframe.columns:
            selected_data = dataframe.dropna(subset=['price'])

            if selected_data is not None:
                # Transform property prices into the target currency
                price_list = selected_data['price'] * exchange_rate
                # convert into numpy array
                prices_numpy = price_list.to_numpy()
                prices_numpy = np.round(prices_numpy, decimals=3)

                return prices_numpy
            else:
                print("No valid price data found in the DataFrame")
                return None
        else:
            print("\nThe column price is not present in the dataset ")
            return None

