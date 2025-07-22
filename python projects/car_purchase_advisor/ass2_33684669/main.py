"""
Name: Shruthi shashidhara shastry
Student ID : 33684669
Last modified Date:23-09-2023
Description :THis file contains 3 methods: The main_menu() function displays available operations for user selection.
             The generate_test_data() function generates twelve cars and three car retailers, each with four cars in their stock.
             The main() function manages program logic, including user input, object methods, and validations.
            It maintains a list of retailer objects, generating unique retailer IDs using the generate_retailer_id() method for each new retailer.
"""

# your imports goes here
import random
from car import Car
from retailer import Retailer
from car_retailer import CarRetailer


def main_menu():
    """this method displays the main menu available operations for users to choose
        None :parameter
        None :return
     """
    print("\n---------Car Purchase Advisor System-------------")
    print("What would you like to do ?")
    print("1) Look for the nearest car retailer")
    print("2) Get car purchase advice")
    print("3) Place a car order")
    print("4) Exit")


def generate_test_data():
    """ this function will generate test data for the program a total of twelve cars and three car retailers
    (each car retailer with four cars in their stock).
    None :parameter
    None :return
    local variables :
            list_retailer: list, list of existing retailers
            car_code_list : list, list of existing car_codes
            street_names : list of few street names to choose randomly from
            suburbs : list of few suburbs to choose randomly from
            states : list of state for postcode to choose randomly from
    """
    list_retailer = []
    car_code_list = []
    street_names = [
        "Clayton Rd", "Wellington Rd", "King St", "Main St", "Park Ave",
        "High St", "Oak St", "Elm St", "Maple Ave", "Cedar Ln"
    ]
    suburbs = [
        "Mount Waverley", "Clayton", "Glen Waverley", "Mulgrave", "Oakleigh",
        "Notting Hill", "Springvale", "Noble Park", "Burwood", "Blackburn"
    ]

    states = ["NSW", "QLD", "SA", "WA", "TAS", "ACT", "NT", "VIC"]

    #Create 3 car retailers
    for i in range(3):
        #making use of random to generate random values
        name_length = random.randint(5, 15)
        retailer_name = ''.join(
            random.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijkklmnopqrstuwxyz ") for each in range(name_length))

        street_name = random.choice(street_names)
        suburb = random.choice(suburbs)
        state = random.choice(states)
        postcode = random.randint(3000, 3999)
        carretailer_address = f'{street_name} {suburb}, {state} {postcode}'

        # Business hours from 6 AM to 11 PM
        start_hour = round(random.uniform(6.0, 9.0), 1)
        end_hour = round(random.uniform(17.5, 23.0), 1)
        carretailer_business_hours = (start_hour, end_hour)

        carretailer_stock = []

        #reatiler_id default value -1
        retailer_id = -1
        retailer_obj = Retailer(retailer_id, retailer_name)
        list_retailer.append(retailer_obj)
        #creating instance of carretailer class
        carretailer_obj = CarRetailer(retailer_id, retailer_name, carretailer_address, carretailer_business_hours,
                                      carretailer_stock)
        #assigning the unique 8 digit retailer_id to each retailer
        carretailer_obj.generate_retailer_id(list_retailer)
        Retailer.retailer_list.append(carretailer_obj)

        #adding car objects for each retailer
        for j in range(4):
            #for generating unique car_code
            while True:
                car_code_random = "".join(random.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZ") for char in range(2))
                car_code_random += "".join(random.choice("0123456789") for num in range(6))
                # check if generated car_code already exists or not
                if car_code_random not in car_code_list:
                    car_code = car_code_random
                    car_code_list.append(car_code)
                    break

            name_len = random.randint(5, 25)
            car_name = ''.join(
                random.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijkklmnopqrstuwxyz ") for each in range(name_len))
            car_capacity = random.randint(2, 20)
            car_horsepower = random.randint(80, 300)
            car_weight = random.randint(1200, 3000)
            car_type = random.choice(["FWD", "RWD", "AWD"])
            #creating car objects
            car = Car(car_code, car_name, car_capacity, car_horsepower, car_weight, car_type)
            carretailer_obj.add_to_stock(car)


def main():
    """The main() function will handle all program logic, including user input, calling methods from objects and handling validations
    None :parameter
    None :return
    """
    #assigning value to local variable
    retailer_list = Retailer.retailer_list

    # generates random data for retailer and car and writes it in stock.txt file
    generate_test_data()

   #until the user wants to exit
    while True:
        #displaying menu for the user to choose from
        main_menu()

        try:
            user_input = input("Select an option from the menu above [1,2,3,4]: ").strip()

            if len(user_input) == 1 and user_input.isdigit() and user_input in ['1', '2', '3', '4']:
                #if user selects option 1
                if user_input == '1':
                    try:
                        user_postcode = input("\nPlease enter your 4-digit postcode: ").strip()
                        # Check if the input is a valid 4-digit number
                        if len(user_postcode) == 4 and user_postcode.isdigit():
                            # Initialize variables to find the nearest retailer
                            nearest_retailer = None
                            # Initialize with a high value
                            min_distance = int('10000')
                            # Iterate through a list of retailers
                            for retailer in retailer_list:
                                # Create a CarRetailer object from retailer data
                                carretailer_obj = CarRetailer(retailer.retailer_id, retailer.retailer_name,
                                                              retailer.carretailer_address,
                                                              retailer.carretailer_business_hours,
                                                              retailer.carretailer_stock)
                                # Calculate the distance between the user's postcode and the retailer's postcod
                                postcode_distance = carretailer_obj.get_postcode_distance(int(user_postcode))

                                # Check if the current retailer is closer than the previously found closest retailer
                                if postcode_distance < min_distance:
                                    min_distance = postcode_distance
                                    nearest_retailer = retailer
                            # If a nearest retailer is found, print its informatio
                            if nearest_retailer:
                                print(
                                    f"\nThe nearest car retailer is: \nRetailer ID:{nearest_retailer.retailer_id},\n"
                                    f"Retailer Name: {nearest_retailer.retailer_name},\nRetailer address:"
                                    f"{nearest_retailer.carretailer_address}")
                            else:
                                # If no retailer is found, print a message
                                print("No car retailer found.")
                        else:
                            # If the input is not a valid 4-digit number, raise a ValueError
                            raise ValueError("\nPostcode must be a 4-digit number.")

                    except ValueError as e:
                        print("\nInvalid input:", e)

                #Check if user input is '2' to access the retailer options
                elif user_input == '2':

                    # Display a list of available car retailers
                    print("\nAvailable Car Retailers are:\n")
                    for retailer in retailer_list:
                        print(f"Retailer ID: {retailer.retailer_id},")
                        print(f"Retailer Name: {retailer.retailer_name},")
                        print(f"Retailer Address: {retailer.carretailer_address}.")
                        print("")

                    try:
                        # Prompt the user to enter an 8-digit retailer ID
                        user_retailer_id = int(
                            input("Please enter the 8-digit retailer Id from the given retailers to proceed: "))
                    except ValueError as e:
                        # Handle invalid input for retailer ID
                        print("\nInvalid input !! Please enter 8-digit retailer Id from given list of retailers")
                        continue

                    selected_retailer = None

                    # Find the selected retailer based on the input retailer_id
                    for retailer in retailer_list:
                        if retailer.retailer_id == user_retailer_id:
                            selected_retailer = retailer.retailer_id
                            selected_retailer_obj = Retailer(retailer.retailer_id, retailer.retailer_name)
                            selected_carretailer_obj = CarRetailer(retailer.retailer_id,
                                                                   retailer.retailer_name, retailer.carretailer_address,
                                                                   retailer.carretailer_business_hours,
                                                                   retailer.carretailer_stock)
                            break

                    if selected_retailer is None:
                        # Handle the case when the retailer ID entered is invalid
                        print("\nInvalid retailer Id. No retailer Found.Please Enter the proper 8 digit retailer ID")
                    else:
                        # If a valid retailer is selected, display options for further actions
                        print("\nThank you for selecting the retailer")
                        while True:
                            # Display sub-menu for car purchase advice
                            print("\nWhat would like to do next?")
                            print("1) Recommend a car")
                            print("2) Get all cars in stock")
                            print("3) Get cars in stock by car types ('AWD','FWD','RWD')")
                            print("4) Get probationary license permitted cars in stock")
                            print("5) Exit and go to Main menu")

                            try:
                                # Prompt the user to select an option from the sub-menu
                                user_sub_input = input("\nselect your option from above menu [1,2,3,4,5]:").strip()
                                if (len(user_sub_input) == 1 and user_sub_input in ['1', '2', '3', '4',
                                                                                    '5'] and user_input.isdigit()):
                                    if user_sub_input == '1':
                                        # Provide a car recommendation based on the selected retailer
                                        print(f"\nCar Retailer :\n\nRetailer ID , Retailer Name are:")
                                        print(selected_retailer_obj)
                                        random_car = selected_carretailer_obj.car_recommendation()
                                        print(
                                            f"\nRecommended Car:\nCar code ,Car name  ,Car capacity,Car horsepower,Car weight,Car type are :")
                                        print(random_car)
                                    elif user_sub_input == '2':
                                        # Display all cars in stock at the selected retailer
                                        stock = selected_carretailer_obj.get_all_stock()
                                        print(f"\nCar Retailer :\n\nRetailer ID , Retailer Name are:")
                                        print(selected_retailer_obj)
                                        print("\nCars in Stock:\n")
                                        for car in stock:
                                            print(
                                                f"\nCar code ,Car name  ,Car capacity,Car horsepower,Car weight,Car type are :")
                                            print(car)

                                    elif user_sub_input == '3':
                                        try:
                                            # Prompt the user to enter car types separated by spaces, e.g., 'FWD AWD RWD'
                                            car_types = input(
                                                "\nEnter car types separated by a single space from (FWD,AWD,RWD): ").upper().strip().split()
                                            valid_car_types = {"AWD", "FWD", "RWD"}

                                            if set(car_types).issubset(valid_car_types):
                                                # Retrieve cars in stock that match the specified car types
                                                cars_by_carType = selected_carretailer_obj.get_stock_by_car_type(car_types)
                                                if cars_by_carType:
                                                    # If matching cars are found, display them
                                                    print(f"\nCar Retailer :\nRetailer ID , Retailer Name are:")
                                                    print(selected_retailer_obj)
                                                    print("\nCars in Stock by Car Types:")
                                                    for car in cars_by_carType:
                                                        print(
                                                            f"\nCar code ,Car name  ,Car capacity,Car horsepower,Car weight,Car type are :")
                                                        print(car)
                                                else:
                                                    #Handle the case when no matching car found
                                                    print("No matching cars found for the specified car types")
                                            else:
                                                # Handle the case when car types not in ["AWD","RWD","FWD"]
                                                print("Its a invalid input please check")
                                        except ValueError as e:
                                            # Handle potential exceptions related to user input
                                            print("Please enter car types separated by space.", e)

                                    elif user_sub_input == '4':
                                        # Display options for license type
                                        print("\nLicense Types:")
                                        print(" \n'L':Learner License\n 'P':Probationary Licence\n 'Full': Full Licence")
                                        # Prompt the user to enter a string representing the license type
                                        licence_type = input(
                                            "\nPlease enter a string according to the licence type mentioned above:").capitalize()
                                        if licence_type in ['L', 'P', 'Full'] and len(licence_type) <= 4:
                                            # Retrieve cars in stock that match the specified license type
                                            cars_by_license_type = selected_carretailer_obj.get_stock_by_licence_type(
                                                licence_type)
                                            if cars_by_license_type:
                                                # If matching cars are found, display them
                                                print(f"\nCar Retailer :\n\nRetailer ID , Retailer Name are:")
                                                print(selected_retailer_obj)
                                                print("\nProbationary licence permitted cars in stock:")
                                                for car in cars_by_license_type:
                                                    print(
                                                        f"\nCar code ,Car name  ,Car capacity,Car horsepower,Car weight,Car type are :")
                                                    print(car)
                                            else:
                                                # Handle the case when no matching cars are found for the specified license type
                                                print("\nNo cars in stock for the specified licence type.")
                                        else:
                                            # Handle the case of an invalid license type input
                                            print("Invalid Input,Please check your input!!")
                                    #Exits the sub menu
                                    elif user_sub_input == '5':
                                        break
                                else:
                                    # Handle invalid sub-menu input
                                    print("\nInvalid Input,Please input any one among [1,2,3,4,5]")

                            except ValueError as e:
                                # Handle invalid input for sub-menu option
                                print("\nInvalid input. Please select a valid option [1,2,3,4,5]", e)

                elif user_input == '3':
                    # Display retailer details and available car details for each retailer
                    print("\nThe retailer details and the car details are given below:")
                    for retailer in retailer_list:
                        print(f"\nRetailer ID : {retailer.retailer_id},")
                        print(f"Retailer Name : {retailer.retailer_name},")
                        for car in retailer.carretailer_stock:
                            print(f"\nCar code ,Car name  ,Car capacity,Car horsepower,Car weight,Car type are :")
                            print(car)
                        print("")

                    try:
                        # Prompt the user to enter Retailer ID and Car code to place an order
                        retailer_id, car_code = input(
                            "Enter Retailer ID and Car code (separated by a space) to place an order: ").strip().split()
                        retailer_id = int(retailer_id)

                        # Find the selected retailer
                        selected_retailer = None
                        for retailer in retailer_list:
                            if retailer.retailer_id == retailer_id:
                                selected_retailer = retailer
                                selected_retailer_obj = CarRetailer(retailer.retailer_id, retailer.retailer_name,
                                                                    retailer.carretailer_address,
                                                                    retailer.carretailer_business_hours,
                                                                    retailer.carretailer_stock)

                                break

                        car_to_order = None
                        try:
                            # Find the car associated with the entered car code for the selected retailer
                            for car in selected_retailer_obj.carretailer_stock:
                                if car.found_matching_car(car_code):
                                    car_to_order = car
                                    break
                        except Exception as e:
                            # Handle exceptions related to car code matching
                            print("This car is not found for this retailer."
                                  " please check the car code properly for the current retailer", e)

                        if selected_retailer is None:
                            # Handle the case when the retailer with the specified ID is not found
                            print("Retailer with the specified ID not found.")
                        else:
                            # Create an order for the selected car and retailer
                            if car_to_order:
                                order = selected_retailer_obj.create_order(car_to_order.car_code)
                                if order:
                                    # Display the order details and the remaining car codes for the retailer
                                    print("\nThe Order details are below:")
                                    print("\t order Id \t\t\t\t,car_code, retailer_id , unix timestamp")
                                    print(order)
                                    print("\nAfter placing the order the retailer has following car codes remaining")
                                    selected_retailer_obj.load_current_stock("../data/stock.txt")
                                    print(selected_retailer_obj.carretailer_stock)
                            else:
                                # Handle the case when there is no car code associated with the retailer ID
                                print("There is no car code associated with this retailer Id please Check your Input!!")

                    except ValueError:
                        # Handle invalid input format for Retailer ID and Car Code
                        print("Invalid input format. Please enter Retailer ID and Car Code separated by a space.")

                ## Exit the main menu and break out of the main loop
                elif user_input == '4':
                    break
            else:
                # Handle invalid input for the main menu
                print("\nInvalid input please enter a valid single digit option from [1,2,3,4]")

        except ValueError as e:
            # Handle exceptions related to user input
            print("\nInvalid input. Please select a valid option [1,2,3,4]", e)


if __name__ == "__main__":
    main()
