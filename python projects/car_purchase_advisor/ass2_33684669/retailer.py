"""
Name: Shruthi shashidhara shastry
Student ID : 33684669
Last modified Date:23-09-2023
Description :This file contains retailer class, its attributes and the instance methods .
"""

import random


class Retailer:
    """
             A class to store the retailer details

             Class variable :
                 retailer_list : list,to store all existing retailers

             Attributes:
                  retailer_id(8 digit integer),retailer_name(str)

             methods:
                -constructor(__init__()) :
                        to initialise and set the values
                -__str__() :
                    to print the retailer object details in a formatted string
                -generate_retailer_id (list_retailer):
                    generates a unique 8 -digit retailer Id

        """

    retailer_list = []

    def __init__(self, retailer_id=0, retailer_name=""):
        """
            This is the constructor which will be executed when a retailer object/instance is created.

            Instance variable
            -----------------
            retailer_id : int , unique 8-digit
            retailer_name : str,can only contain alphabetic characters and whitespaces
        """
        self.retailer_id = retailer_id
        self.retailer_name = retailer_name

    def __str__(self):
        """
            Returns
            --------------
            A formatted string containing retailer details
        """
        formatted_str = f'{self.retailer_id}, {self.retailer_name}'
        return formatted_str

    def generate_retailer_id(self, list_retailer):
        """
        Method to generate the unique 8-digit retailer_id

        Parameter: list_retailer: list of all existing retailers
        returns : unique 8-digit retailer_id
        """

        #uses random to generate a unigue 8-digit retailer_id
        new_retailer_id = random.randint(10000000, 99999999)
        # keep checking until find the unique one
        while True:
            # makes sure that generated reatiler_id is not present in existing retailer list
            if new_retailer_id not in list_retailer:
                #if so then it sets ratailer_id to self.retailer_id
                self.retailer_id = new_retailer_id
                break
            else:
                # if generated reatiler_id is present in existing retailer list , new retailer_id is generated
                new_retailer_id = random.randint(10000000, 99999999)









