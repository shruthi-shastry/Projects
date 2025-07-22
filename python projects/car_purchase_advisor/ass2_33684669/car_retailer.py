"""
Name: Shruthi shashidhara shastry
Student ID : 33684669
Last modified Date:23-09-2023
Description :This file contains carretailer class, its attributes and the instance methods .
"""

import re
import time
import random
from order import Order
from retailer import Retailer

class CarRetailer(Retailer):
    """
                  A class to store the CarRetailer details

                  Attributes:
                       retailer_id  : int, unique 8-digit id
                       retailer_name : str, retailer name
                       <these both are initialised in retailer class, this retailer is inherited in this(CarRetailer) class>
                       carretailer_address: str ,the address format will be street address followed by the state and postcode
                       carretailer_business_hours : a tuple of floats representing start and end hours in 24hr.
                       carretailer_stock : list, list of all car_codes available for that particular retailer.

                  methods:
                     -constructor(__init__()) :
                             to initialise and set the values
                     -__str__() :
                         to print the order object details in a formatted string
                     -load_current_stock(path):
                            This method is to load the current stock of the car retailer according to the
                            retailer_id from the stock.txt file
                     -is_operating(cur_hour):
                            This method returns a boolean value to indicate whether the car retailer is currently operating
                            (i.e., within working hours)
                     -get_all_stock():
                            This method returns the information of all available cars currently in stock at the carretailer.
                     -get_postcode_distance(postcode):
                            This method returna the absolute difference of the postcode input by the user and that of the car retailer
                     -remove_from_stock(car_code):
                            Removes a car from the current stock at the car retailer.A boolean value is returned to indicate whether the removal is successful.
                     -add_to_stock(car):
                            adds a car to the current stock.A boolean value is returned to indicate whether the adding is successful.
                     - get_stock_by_car_type(car_types)
                            Returns the list of cars in the current stock by specific car_type values.
                     -get_stock_by_licence_type()
                            Returns the list of cars in the current stock that are not forbidden by the driver’s licence type.
                     - car_recommendation()
                            Returns a car that is randomly selected from the cars in stock at the current car retailer
                     -create_order(car_code)
                            Returns an order object of a created order
       """

    def __init__(self, retailer_id=0, retailer_name="", carretailer_address="", carretailer_business_hours=(6.0, 23.0),
                 carretailer_stock=[]):
        """
                      This is the constructor which will be executed when a carRetailer object/instance is created.

                      Instance variable
                      -----------------
                      retailer_id : int (unique 8-digit number)
                      retailer_name : str
                      carretailer_address :  str ,(eg:Wellington Road Clayton, VIC 3800)
                      carretailer_business_hours : tuple, e.g., (8.5,17.5) - business hours are from 8:30AM inclusive to 5:30PM inclusive
                      carretailer_stock : list ,list of all car_codes present for a particular retailer

        """
        Retailer.__init__(self, retailer_id, retailer_name)
        self.carretailer_address = carretailer_address
        self.carretailer_business_hours = carretailer_business_hours
        self.carretailer_stock = carretailer_stock

    def __str__(self):
        """ Returns:
             A formatted string containing carRetailer details
               """
        return f'"{self.retailer_id}, {self.retailer_name}, {self.carretailer_address}, {self.carretailer_business_hours}, {self.carretailer_stock}"'

    def load_current_stock(self, path):

        """ This method is to load the current stock of the car retailer according to the retailer_id from the stock.txt file
        and store the car_codes of the Cars in a list, this list will be saved to carretailer_stock.

        Parameter : path (the path to the stock file)
        Returns : no return value

        """
        #regular expression to find car codes
        car_code = r'[A-Z]{2}\d{6}'

        try:
            # Read the stock.txt file
            with open(path, "r") as stockfile:
                #read all lines and return list of each line
                lines = stockfile.readlines()
                for line in lines:
                    #splitting the data
                    data = line.strip().split(", ",6)
                    retailer_id = int(data[0])
                    # Check if the retailer_id matches the current retailer's ID
                    if retailer_id == self.retailer_id:
                        # Use regular expression to extract car codes
                        #findall returns the list of the car code
                        car_codes = re.findall(car_code, data[6])
                        #assign the list of car codes to carretailer_stock
                        self.carretailer_stock = car_codes
                        break

        except FileNotFoundError:
            print(f"File '{path}' not found.")
        except Exception as e:
            print(f"An error occurred while loading stock: {str(e)}")

    def is_operating(self, cur_hour):

        """ This method returns a boolean value to indicate whether the car retailer is currently operating (i.e., within working hours)

            Parameter : cur_hour (A float value indicating current hour in 24H format, e.g., 12.5 - 12:30PM)
            Returns : True (is operating) / False (is not operating)

        """
        # Checking if the current hour is within the retailer's business hours
        start_hour, end_hour = self.carretailer_business_hours
        # returns true if its withing operating hours or else false
        return start_hour <= cur_hour <= end_hour

    def get_all_stock(self):
        """This method returns the information of all available cars currently in stock at the carretailer
           parameter : none
           returns :list of Car objects
        """
        car_objects = [car for car in self.carretailer_stock]
        #returns list of Car objects  for that particular retailer
        return car_objects


    def get_postcode_distance(self,postcode):
        """Return the absolute difference of the postcode input by the user and that of the car retailer.

            parameter: postcode (An 4-digit integer)
            Returns: the absolute difference between the two postcodes as integers
        """
        #Extracting the postcode of the selected retailer from the carretailer_address
        carretailer_postcode = int(self.carretailer_address[-4:])
        #absolute difference of the postcode input by the user and that of the car retailer
        absolute_difference = abs(postcode - carretailer_postcode)
        #returns the absolute difference
        return absolute_difference

    def remove_from_stock(self, car_code):
        """Remove a car from the current stock for that particular car retailer.

            Parameter: car_code (the car_code of the car to be removed)
            Returns:True (successful) / False (unsuccessful)
        """
        car_to_remove = None

        # Find the car with the specified car_code in the current stock
        for car in self.carretailer_stock:
            if car.found_matching_car(car_code):
                car_to_remove = car
                break

        if car_to_remove is not None:
            # Remove the car from the current stock
            self.carretailer_stock.remove(car_to_remove)

            try:
                # Read the entire stock file
                with open("../data/stock.txt", "r") as stockfile:
                    lines = stockfile.readlines()

                # Find the line that contains the retailer's data
                retailer_line = None
                #find the index and line which contains the current reatiler id
                for i, line in enumerate(lines):
                    #search returns the match object if found else none
                    if re.search(fr"\b{self.retailer_id}\b", line):
                        retailer_line = i
                        break

                if retailer_line is not None:
                    # Remove the car entry from the retailer's data
                    retailer_data = lines[retailer_line].strip()
                    car_data = f'"{car_code}, {car_to_remove.car_name}, {car_to_remove.car_capacity}, {car_to_remove.car_horsepower}, {car_to_remove.car_weight}, {car_to_remove.car_type}"'
                    #replace the car data with ' '
                    updated_retailer_data = retailer_data.replace(car_data, '').replace(', ,', ', ').strip()
                    updated_retailer_data += '\n'
                    lines[retailer_line] = updated_retailer_data

                    # Rewrite the stock file with the updated content
                    with open("../data/stock.txt", "w") as stockfile:
                        stockfile.writelines(lines)

                print(f"Car with code {car_code} successfully removed from stock.")
                return True
            except FileNotFoundError:
                print(f"File not found.")
            except Exception as e:
                print(f"An error occurred while loading stock: {str(e)}")
        else:
            print(f"Car with code {car_code} not found in stock. Removal unsuccessful.")
            return False

    def add_to_stock(self, car):
        """ Add a car to the current stock.
        A boolean value is returned to indicate whether the adding is successful.

        parameter: car (a Car object)
        Returns :True (successful) / False (unsuccessful)
        """

        #checking if car already exist before adding
        if car in self.carretailer_stock:
            print("Car already exists in the current stock.")
            return False  # Car already exists, adding unsuccessful

        # Find the retailer with the matching retailer_id
        matching_retailer = None
        for retailer in Retailer.retailer_list:
            if retailer.retailer_id == self.retailer_id:
                matching_retailer = retailer
                break

        # If the retailer is found, add the car to its stock
        if matching_retailer:
            matching_retailer.carretailer_stock.append(car)

            # Save the data to "stock.txt"
            with open("../data/stock.txt", "w") as stockfile:
                for retailer in Retailer.retailer_list:
                    car_data = ', '.join([str(car) for car in retailer.carretailer_stock])
                    retailer_info = f"{retailer.retailer_id}, {retailer.retailer_name}, {retailer.carretailer_address}, {retailer.carretailer_business_hours}, [{car_data}]\n"
                    stockfile.write(retailer_info)
            return True
        else:
            print("Retailer not found.")


    def get_stock_by_car_type(self, car_types):
        """this method returns the list of cars in the current stock based on specific car_type values.
            Parameter: car_types (the list of car_type values of the cars to be fetched)
            Returns : A list of Car objects
        """
        cars = []
        for car in self.carretailer_stock:
            #if the car type is in car_types specified then add it to the car list
            if car.get_car_type() in car_types:
                cars.append(car)
        return cars

    def get_stock_by_licence_type(self, licence_type):
        """ this method returns the list of cars in the current stock that are not forbidden by the driver’s licence type.
            parameter : licence_type (a string value of either “L” (Learner Licence), “P” (Probationary Licence), or “Full” (Full Licence))
            Returns : A list of Car objects
        """
        cars = []
        for car in self.carretailer_stock:
            #condition only for probationary licence
            if licence_type == "P":
                #check if its probationary licence prohibited vehicle or not
                if not car.probationary_licence_prohibited_vehicle():
                    cars.append(car)
            else:
                cars.append(car)
        return cars

    def car_recommendation(self):
        """this method returns a car that is randomly selected from the cars in stock for the current car retailer.

            parameter: N/A

            Returns: A Car object
         """
        if not self.carretailer_stock:
            print("No cars available in stock for recommendation.")
            return None

        # Randomly select a car from the current stock
        recommended_car = random.choice(self.carretailer_stock)
        return recommended_car

    def create_order(self, car_code):

        """Returns an order object of a created order.
            parameter:
                car_code (the car_code of the car to be ordered)

            Returns:
                An Order object
            """
        #get the current time when order is being placed
        current_time = time.localtime()
        time_decimal = current_time.tm_hour + current_time.tm_min / 60

        retailer_obj = Retailer(self.retailer_id,self.retailer_name)
        carretailer_obj = CarRetailer(self.retailer_id, self.retailer_name,self.carretailer_address,
                                   self.carretailer_business_hours,self.carretailer_stock)

        #check if the order is being placed within the business hours
        if carretailer_obj.is_operating(time_decimal):
            # Convert the datetime object to a UNIX timestamp
            order_creation_time = int(time.mktime(current_time))

            car_in_stock = None
            for i, car in enumerate(self.carretailer_stock):
                if car.car_code == car_code:
                    car_in_stock = car
                    break

            # Check if the car exists and is not available in stock
            if not car_in_stock :
                return "Car not available in stock."

            # Create and store the order
            order = Order(car_in_stock, retailer_obj, str(order_creation_time), 0)

            with open("../data/order.txt", "a") as order_file:
                order_file.write(
                    f"{order.order_id}, {order.order_car.car_code}, {order.order_retailer.retailer_id} ,{order_creation_time}\n")
                #after order is being placed remove it from the stock
                if(carretailer_obj.remove_from_stock(car_in_stock.car_code)):
                    # Display a success message
                    print(f"Car details: {car_in_stock} successfully removed from stock.")
                    print("Order placed successfully!!.")

                    return order
                else:
                    print(f"Car details: {car_in_stock} removal unsuccessfull, could not be removed from stock as its not present in the stock")

        else:
            print("Retailer is currently closed. Please place your order during business hours.")








