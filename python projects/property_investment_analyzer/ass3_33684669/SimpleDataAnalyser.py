'''
Name : Shruthi Shashidhara Shastry
Student Id : 33684669
Last modified date: 20-10-2023
Description :This file contains SimpleDataAnalyser class ,its attribute and instance methods
    '''

import pandas as pd

pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)

class SimpleDataAnalyser:

    '''Class Description: A class for analyzing property data using various methods.
         Attribute:
                dataframe : The csv dataset to be visualised.

        methods:
            - suburb_summary(self, property_data, suburb): Calculate and display summary statistics for a specific suburb or all suburbs.
            - avg_land_size(self, property_data, suburb): Calculate the average land size for a specific suburb or all suburbs.
            - recursive_binary_search(self, the_list, target_item): Perform a recursive binary search to find a target item in a reverse sorted list.
            - locate_price(self, target_price, data, target_suburb): Find a target price in a reverse sorted list of prices for a specific suburb.'''

    def __init__(self,dataframe):
        '''
                Constructor to initialize the class instance with a DataFrame containing property data.

                    Instance variable:
                    - dataframe (pandas.DataFrame): The DataFrame containing property data.
                '''
        self.property_data = dataframe

    def suburb_summary(self, property_data, suburb):
        '''
                Calculate and display summary statistics for a specific suburb or all suburbs.

                Parameters:
                    - property_data (pandas.DataFrame): The DataFrame containing property data.
                    - suburb (str): The suburb to analyze or 'all' for all suburbs.

                Returns: None
                '''

        if property_data is None:
            print("Error!! data not loaded")
            return

        column_to_check = 'suburb'
        # check if the suburb column exists
        if column_to_check in property_data.columns:

            if suburb != "all" and suburb not in property_data['suburb'].str.lower().values:
                print(f"\nSuburb '{suburb}' not found in the dataset.Please enter a valid suburb")
                return

            if suburb == "all":
                # Calculate summary statistics for all suburbs
                selected_data = property_data.dropna(subset=['bedrooms', 'bathrooms', 'parking_spaces'])
                if not selected_data.empty:
                    summary_all = selected_data[['bedrooms', 'bathrooms', 'parking_spaces']].agg(
                        ['mean', 'std', 'median', 'min', 'max','count'])
                    print("\nSummary for all suburbs:")
                    print(summary_all)
                    # Calculate summary statistics for all suburbs based on property_type
                    summary_property_type = selected_data.groupby('property_type')[
                        ['bedrooms', 'bathrooms', 'parking_spaces']].agg(
                        ['mean', 'std', 'median', 'min', 'max', 'count'])
                    print("\nSummary for all suburbs based on property type :")
                    print(summary_property_type)
                else:
                    print("\nNo valid bedrooms, bathrooms and parking_space found")
                    return

            else:
                # Filter the dataframe for the specified suburb
                selected_data = property_data.dropna(subset=['bedrooms', 'bathrooms', 'parking_spaces'])
                if not selected_data.empty:
                    suburb_selected_data = selected_data[selected_data['suburb'].str.lower() == suburb]
                else:
                    print("\nNo valid bedrooms, bathrooms and parking_space found  ")
                    return

                if suburb_selected_data is not None:
                    # Calculate summary statistics for the specific suburb
                    summary_selected_data = suburb_selected_data[['bedrooms', 'bathrooms', 'parking_spaces']].agg(
                        ['mean', 'std', 'median', 'min', 'max','count'])
                    print(f"\nSummary for suburb '{suburb}':")
                    print(summary_selected_data)
                    # Calculate summary statistics for the specific suburb based on property
                    summary_property_type = suburb_selected_data.groupby('property_type')[
                        ['bedrooms', 'bathrooms', 'parking_spaces']].agg(
                        ['mean', 'std', 'median', 'min', 'max','count'])
                    print(f"\nSummary for  suburb '{suburb}' based on property_type :")
                    print(summary_property_type)

                    print(
                        "\nNOTE:The std deviation becomes nan due to lack of data points or when all data points are identical")

                else:
                    print(f"No data available for suburb '{suburb}'.")
                    return
        else:
            print("\nThe column suburb is not present in the dataset ")
            return


    def avg_land_size(self, property_data, suburb):
        '''
                This method calculates the average land size for a specific suburb or all suburbs.

                Parameters:
                    - property_data (pandas.DataFrame): The DataFrame containing property data.
                    - suburb (str): The suburb to analyze or 'all' for all suburbs.

                Returns:
                    - float value : The average land size in square meters round to 3 decimal poinrs, or None if there's an error.
                '''
        if property_data is None:
            print("\nError!! data not loaded")
            return None

        if suburb != "all" and suburb not in property_data['suburb'].str.lower().values:
            print(f"\nSuburb '{suburb}' not found in the dataset.Please enter a valid suburb.")
            return None

        column_to_check = 'suburb'
        # check if the suburb column exists
        if column_to_check in property_data.columns:

            if suburb == 'all':
                filtered_dataframe = property_data
            else:
                filtered_dataframe = property_data[property_data['suburb'].str.lower() == suburb]

            if not filtered_dataframe.empty:
                # Remove rows with invalid or missing land size values
                filtered_df = filtered_dataframe.dropna(subset=['land_size', 'land_size_unit'])
                filtered_df = filtered_df[filtered_df['land_size'] != -1]

                if not filtered_df.empty:
                    # Calculate the average land size in square meters
                    valid_land_sizes = filtered_df['land_size']
                    valid_land_size_units = filtered_df['land_size_unit']
                    conversion_factors = {
                        'm²': 1,  # Square meters
                        'ha': 10000  # Hectares (1 hectare = 10,000 square meters)
                    }
                    valid_land_sizes_in_m2 = valid_land_sizes * valid_land_size_units.map(conversion_factors)
                    average_land_size = valid_land_sizes_in_m2.mean()
                    return round(average_land_size, 2)
                else:
                    print("\nNo valid land sizes found for the specified suburb.")
                    return None

            else:
                print("\nNo valid suburbs details found for the specified suburb.")
                return None

        else:
            print("\nThe column suburb is not present in the dataset ")
            return None



    def recursive_binary_search(self,the_list, target_item):
        '''reference : https://edstem.org/au/courses/12192/lessons/39395/slides/273276'''
        '''
               Perform a recursive binary search to find a target item in a reverse sorted list.

               Parameters:
                   - the_list (list): The reverse sorted list to search in.
                   - target_item: The item to search for.

               Returns:
                   - bool: True if the target item is found, False otherwise.
               '''
        # repeatedly divide the list into two halves
        # as long as the target item is not found
        if len(the_list) == 0:  # the list cannot be divided further
            return False
        else:
            # find the middle position
            mid = len(the_list) // 2

            # check if the target is equal to the middle item
            if the_list[mid] == target_item:
                return True

            # check if the target is greater than the middle item as the list is reverse sorted
            elif target_item > the_list[mid]:
                # create a smaller list
                smaller_list = the_list[:mid]
                # call the function itself
                return self.recursive_binary_search(smaller_list, target_item)

            # the target is lesser than the middle item
            else:
                # create a smaller list
                smaller_list = the_list[mid + 1:]
                # call the function itself
                return self.recursive_binary_search(smaller_list, target_item)

    def locate_price(self, target_price, data, target_suburb):
        '''
                Find a target price in a reverse sorted list of prices for a specific suburb.

                Parameters:
                    - target_price (float): The target price to locate.
                    - data (pandas.DataFrame): The DataFrame containing property data.
                    - target_suburb (str): The suburb to search within.

                Returns:
                    - bool: True if the target price is found, False otherwise.
                '''

        if data is None:
            print("\nError!! data not loaded")
            return None

        column_to_check = 'suburb'
        # check if the suburb column exists
        if column_to_check in data.columns:

            # Convert target_price to a float
            target_price = float(target_price)

            if target_suburb not in data['suburb'].str.lower().values:
                print(f"\nSuburb {target_suburb} not found in the dataset")
                return None

            # Filter data for the specified suburb
            suburb_data = data[data['suburb'].str.lower() == target_suburb]

            # Remove rows with missing 'price' values
            selected_data = suburb_data.dropna(subset=['price'])

            if not selected_data.empty:
                prices = selected_data['price']
                price_list = prices.to_list()

                ''' reverse insertion sorting reference : https://edstem.org/au/courses/12192/lessons/39395/slides/273276'''
                # make a copy of the original list
                reverse_sorted_list = price_list[:]
                for iter in range(1, len(reverse_sorted_list)):
                    target_idx = iter
                    while target_idx > 0:
                        if reverse_sorted_list[target_idx] > reverse_sorted_list[target_idx - 1]:
                            reverse_sorted_list[target_idx], reverse_sorted_list[target_idx - 1] = reverse_sorted_list[
                                target_idx - 1], reverse_sorted_list[target_idx]
                            target_idx -= 1
                        else:
                            break

                found_flag = self.recursive_binary_search(reverse_sorted_list, target_price)

                return found_flag
            else:
                print("\nNo valid price values found in the dataset for that suburb")
                return None

        else:
            print("\nThe column suburb is not present in the dataset ")
            return None

