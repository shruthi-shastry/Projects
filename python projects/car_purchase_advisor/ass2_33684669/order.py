"""
Name: Shruthi shashidhara shastry
Student ID : 33684669
Last modified Date:23-09-2023
Description :This file contains order class, its attributes .
"""
import random

class Order:
    """
               A class to store the order details

               Attributes:
                    order_car : car object
                    order_retailer : retailer object
                    order_creation_time : int,UNIX timestamp of the order creation time
                    order_id : str which contains unique order id, car_code,retailer_id,UNIX timestamp

               methods:
                  -constructor(__init__()) :
                          to initialise and set the values
                  -__str__() :
                      to print the order object details in a formatted string
                  -generate_order_id (car_code):
                      generates a unique order id based on set of steps using random string ,car_code,retailer_id and UNIX timestamp

    """
    def __init__(self, order_car=None, order_retailer=None, order_creation_time=None, order_id=" "):
        """
        This is the constructor which will be executed when a order object/instance is created.

        Instance variable
        -----------------
        order_car  : car object, contains car details(car_code,name,capacity,horsepower,weight,carType
        order_retailer : retailer object, contains retailer_id and retailer_name
        order_creation_time : int ,UNIX timestamp of the time during order Creation
        order_id : str, which contains unique order id, car_code,retailer_id,UNIX timestamp
        """
        self.order_car = order_car
        self.order_retailer = order_retailer
        self.order_creation_time = order_creation_time
        self.order_id = self.generate_order_id(order_car.car_code)

    def __str__(self):
        """
          Returns
        --------------
         A formatted string containing order details
        """
        formatted_str = f'{self.order_id}, {self.order_car.car_code},{self.order_retailer.retailer_id}, {self.order_creation_time}'
        return formatted_str

    def generate_order_id(self, car_code):

        """ method to generate unique order id

        parameter :car_code, of the current car order to be placed
        returns: unique order id(str), using random string,str_1(defined below) ,car_code,retailer_id and UNIX timestamp

        """
        #local variable str_1
        str_1 = "~!@#$%^&*"

        # Step 1: Generate a random string of 6 lowercase alphabetic characters
        rm_string_lower = ''.join([random.choice('abcdefghijklmnopqrstuvwxyz') for each in range(6)])

        # Step 2: Convert every second character to uppercase
        rm_string_lowerUppercase = ''.join(
            [char.upper() if index % 2 == 1 else char for index, char in enumerate(rm_string_lower)])

        # Step 3: Get ASCII codes of characters from Step 2
        ascii_values = [ord(each_chr) for each_chr in rm_string_lowerUppercase]

        # Step 4: Calculate powered ASCII codes and get remainders
        remainders = [(value ** 2) % len(str_1) for value in ascii_values]

        # Step 5: Map remainders to characters from str_1
        mapped_characters = [str_1[remainder] for remainder in remainders]

        # Step 6: Append characters from Step 5 n times  to the string updated in Step 2
        unique_order_id = rm_string_lowerUppercase
        for index, char in enumerate(rm_string_lowerUppercase):
            unique_order_id += mapped_characters[index] * index

        # Step 7: Append car_code and order_creation_time to the order
        unique_order_id += car_code + self.order_creation_time

        #return the generated unique_order_id
        return unique_order_id
