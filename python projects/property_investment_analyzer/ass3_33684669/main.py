'''
Name : Shruthi Shashidhara Shastry
Student Id : 33684669
Last modified date:20-10-2023
Description :This file contains two methods : main_menu() and main() methods
                -main_menu() : method displays the menu for the users to choose
                - main() : will handle  program logic, including user input, calling methods from objects, error handling and validations.
    '''


#import statements
from DataExtraction import DataExtraction
from SimpleDataAnalyser import SimpleDataAnalyser
from DataVisualizer import DataVisualizer

def main_menu():
    """This method displays the main menu available operations for users to choose
            None :parameter
            None :return
         """
    print("\nWELCOME TO INVESTOR APPLICATION ")
    print("\nInvestor Application Menu:")
    print("1.Suburb Property Summary")
    print("2.Average Land Size")
    print("3.Property Value Distribution")
    print("4.Sales Trend")
    print("5.Locate Property by Price")
    print("6.Exit")

def main():
    """The main() function will handle  program logic, including user input, calling methods from objects, error handling and validations
     None :parameter
     None :return
     """
    # Create instances of DataExtraction, SimpleDataAnalyser, and DataVisualizer
    extraction = DataExtraction()
    # extract the dataframe from the datatset
    dataframe = extraction.extract_property_info("property_information.csv")
    if dataframe is None:
        print("The DataFrame is Empty. Exiting the program.")
    elif dataframe.isnull().all().all():
        print("The DataFrame is empty, it contains only NaN values. Exiting the program.")
    else:
        data_analyse = SimpleDataAnalyser(dataframe)
        data_visualise = DataVisualizer(dataframe)

        while True:

            # Display the main menu
            main_menu()

            # Get the user's choice
            choice = input(
                "\nWhat would you like to know / get information about ?\n\nPlease Enter your choice (1-6) : ")

            # Validate the user's choice
            if (choice.strip().isdigit() and len(choice.strip()) == 1 and choice.strip() in ['1', '2', '3', '4', '5',
                                                                                             '6']):

                if choice.strip() == '1':
                    # Get suburb information
                    print("\n The different suburbs available in the dataset are :")
                    dataframe = dataframe.dropna(subset=['suburb'])
                    print(dataframe['suburb'].unique())
                    suburb = input("\nEnter the suburb name from above list for which you want the suburb summary "
                                   "\n(if you require summary for all the suburbs enter \"all\") : ")

                    # Validate suburb input and call the suburb_summary method
                    if all(x.isalpha() or x.isspace() for x in suburb):
                        data_analyse.suburb_summary(dataframe, suburb.lower().strip())
                    else:
                        print("\n INVALID USER INPUT!!"
                              "\nPlease enter a valid suburb!! "
                              "eg: clayton, burwood etc")

                elif choice.strip() == '2':
                    print("\nThe suburbs available in the dataset are :")
                    dataframe = dataframe.dropna(subset=['suburb'])
                    print(dataframe['suburb'].unique())
                    # Get suburb input , for which suburb is the avg land size is necessary
                    suburb = input(
                        "\nEnter the suburb name from above list for which you want the average land size value "
                        "\n(if you require summary for all the suburbs enter \"all\") : ")
                    # Validate suburb input and call the avg_land_size method
                    if all(x.isalpha() or x.isspace() for x in suburb):
                        # Get average land size
                        if (data_analyse.avg_land_size(dataframe, suburb.lower().strip())):
                            print(f"\nThe average land size for {suburb} is :")
                            print(data_analyse.avg_land_size(dataframe, suburb.lower().strip()), "m^2")
                    else:
                        print("\nINVALID USER INPUT!!"
                              "\nPlease enter a valid suburb!! "
                              "eg: clayton, burwood etc")

                elif choice.strip() == '3':
                    print(
                        '\nFor Property value distribution we have the following dictionary with currency and exchange rate :')
                    print(
                        '\ncurrency_dict = {"AUD": 1, "USD": 0.66, "INR": 54.25, "CNY":4.72, "JPY": 93.87, "HKD": 5.12, "KRW": 860.92, "GBP": 0.51,"EUR": 0.60, "SGD": 0.88}')
                    print("\nThe suburbs available in the dataset are :")
                    dataframe = dataframe.dropna(subset=['suburb'])
                    print(dataframe['suburb'].unique())
                    suburb = input(
                        "\nEnter the suburb name from above list for which you want the histogram of property value distribution"
                        "\n(if you require summary for all the suburbs enter \"all\") : ")
                    target_currency = input("Enter the currency from the available currency (like AUD,INR) : ")
                    # Validate suburb and currency input and call the prop_val_distribution method
                    if all(x.isalpha() or x.isspace() for x in suburb) and target_currency.isalpha():
                        data_visualise.prop_val_distribution(dataframe, suburb.lower().strip(), target_currency.upper())
                    else:
                        print("Invalid suburb or currency input. Please enter a valid input.")
                elif choice.strip() == '4':
                    # Get sales trend
                    data_visualise.sales_trend(dataframe)

                elif choice.strip() == '5':
                    # Locate property by price
                    print("\nThe suburbs available in the dataset are :")
                    dataframe = dataframe.dropna(subset=['suburb'])
                    print(dataframe['suburb'].unique())
                    target_suburb = input(
                        "\nEnter the suburb name from above list: ")
                    target_price = input("\nEnter the price that needs to be searched in numeric :")
                    # Validate suburb and price input and call the locate_price method
                    if all(x.isalpha() or x.isspace() for x in target_suburb) and target_price.strip().isnumeric():
                        found = data_analyse.locate_price(target_price, dataframe, target_suburb.lower().strip())
                        if (found):
                            print(
                                f"\nThe price {target_price} is present in the list of prices in the {target_suburb} suburb")
                        elif (found == False):
                            print(
                                f"\nThe price {target_price} is not present in the list of prices in the {target_suburb} suburb")
                    else:
                        print("Invalid suburb or price input. Please enter a valid input.")

                elif choice.strip() == '6':
                    # Exit the program
                    break

            else:
                print("\nINVALID CHOICE !! \nPlease enter a valid choice from digits 1-6")



if __name__ == "__main__":
    main()

#TEST CODES

#3.2 extract_property_info

# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
# len(df)
# this should output 118771

#3.3 currency exchange method

# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
#
# exchange_rate_usd = 0.66
#
# converted_prices = de.currency_exchange(df, exchange_rate_usd)
# if converted_prices is not None:
#     print("Converted Prices :")
#     print(converted_prices)
# else:
#     print("Currency conversion failed. Check the data and exchange rate.")

# this outputs :
# Converted Prices:
# [636900. 267300. 581460. ... 500280. 442200. 343728.]

#3.4 suburb property summary

# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
# # Sample instance of the class
# data_analyser = SimpleDataAnalyser(df)
#
# # Analyze a specific suburb
# suburb = 'clayton'
# data_analyser.suburb_summary(df, suburb)
#
# # Analyze all suburbs
# suburb = 'all'
# data_analyser.suburb_summary(df, suburb)
#
#this outputs:
# Summary for suburb 'clayton':
#          bedrooms  bathrooms  parking_spaces
# mean     3.127349   1.631886        1.564809
# std      1.585075   1.111867        1.102015
# median   3.000000   1.000000        1.000000
# min      1.000000   1.000000        0.000000
# max     30.000000  20.000000       31.000000
#
# Summary for all suburbs:
#          bedrooms  bathrooms  parking_spaces
# mean     3.232831   1.769863        1.809263
# std      1.048621   0.793599        2.574261
# median   3.000000   2.000000        2.000000
# min      0.000000   0.000000        0.000000
# max     30.000000  65.000000      819.000000

#Additionally the mean,median,std,min and max values for the property_type within the specified suburb is also displayed.


#3.5 Average Land size:

# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
# data_analyser = SimpleDataAnalyser(df)  # Assuming you have an instance of SimpleDataAnalyser
# # Calculate the average land size for a specific suburb
# suburb = 'glen waverley'
# average_size = data_analyser.avg_land_size(df, suburb)
# if average_size is not None:
#     print(f"Average land size in '{suburb}': {average_size} square meters")
#
# # Calculate the average land size for all suburbs
# suburb = 'all'
# average_size = data_analyser.avg_land_size(df, suburb)
# if average_size is not None:
#     print(f"Average land size for all suburbs: {average_size} square meters")

#this outputs:
#Average land size in 'glen waverley': 673.54
#Average land size for all suburbs: 650.42

#3.6 property value distribution
# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
# data = DataVisualizer(df)
# suburb_to_analyze = 'clayton south'
# target_currency = 'INR'
#
#
# data.prop_val_distribution(df, suburb_to_analyze, target_currency)

#this outputs:
# The image of the histogram successfully stored in your local as property_value_distribution_clayton south.png
# NOTE: it stores the histogram as png file in ur local

#3.7 Sales Trend
# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
# data = DataVisualizer(df)

# data.sales_trend(df)
# This outputs:
# The image of the line graph was successfully stored in your local as sales_trend_chart.png
# NOTE: it stores the sales trend line graph as png file in ur local



#3.8 Locate price based on suburb and specified price
#
# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
# analyse = SimpleDataAnalyser(df)
#
# # Target price to locate
# target_price = '965000'
# target_suburb = 'clayton'
#
# # Use the locate_price method
# found_flag = analyse.locate_price(target_price, df, target_suburb)
#
# if found_flag:
#     print(f"Target price {target_price} found in {target_suburb}.")
# else:
#     print(f"Target price {target_price} not found in {target_suburb}.")
#this outputs:
#Target price 965000 found in clayton.

#recursive binary Search
# de = DataExtraction()
# df = de.extract_property_info("property_information.csv")
# analyse = SimpleDataAnalyser(df)
#
# my_list = [10, 8, 6, 4, 2, 0]
#
# # Specify the target item you want to search for
# target = 4
#
# # Call the recursive_binary_search method
# result = analyse.recursive_binary_search(my_list, target)
#
# # Check if the target item was found
# if result:
#     print(f"Target item {target} was found in the list.")
# else:
#     print(f"Target item {target} was not found in the list.")
#this outputs
#Target item 4 was found in the list.


#insertion sort
# price_list = [1000, 500, 750, 1200, 850]
#
# # Create a copy of the original list for sorting
# reverse_sorted_list = price_list[:]
#
# # Sort the list in reverse order (descending)
# for iter in range(1, len(reverse_sorted_list)):
#     target_idx = iter
#     while target_idx > 0:
#         if reverse_sorted_list[target_idx] > reverse_sorted_list[target_idx - 1]:
#             reverse_sorted_list[target_idx], reverse_sorted_list[target_idx - 1] = reverse_sorted_list[
#                 target_idx - 1], reverse_sorted_list[target_idx]
#             target_idx -= 1
#         else:
#             break
#
# # Print the reverse sorted list
# print("Reverse Sorted List (Descending Order):", reverse_sorted_list)
#this outputs:
# Reverse Sorted List (Descending Order): [1200, 1000, 850, 750, 500]