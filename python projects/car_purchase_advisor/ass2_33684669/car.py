"""
Name: Shruthi shashidhara shastry
Student ID : 33684669
Last modified Date:23-09-2023
Description :This file contains car class, its attributes and the instance methods .
"""
class Car:
    """
         A class to store the car details

         Attributes:
              car_code(str), car_name(str), car_capacity(int), car_horsepower(int), car_weight(int), car_type(str)

         methods:
            -constructor(__init__()) :
                    to initialise and set the values
            -__str__() :
                to print the car object details in a formatted string
            -probationary_licence_prohibited_vehicle() :
                method to check whether the vehicle is a prohibited vehicle for probationary licence drivers or not
            -found_matching_car(car_code):
                method to check whether the current vehicle is the one to be found based on a car_code
            -get_car_type():
                method to get the car_type.
    """
    def __init__(self, car_code="", car_name="", car_capacity=8, car_horsepower=250, car_weight=1300, car_type="FWD"):
        """
               This is the constructor which will be executed when a car object/instance is created.

               Instance variable
               -----------------
               car_code :str,must be unique and in the format of two uppercase letters plus 6 digits, e.g.,MB123456
               car_name: str, car name
               car_capacity : int ,Each car has a maximum seating capacity
               car_horsepower : int, horsepower of car in kilowatts
               car_weight : int, in kilograms - the car weight
               car_type : str, car type value should be one of “FWD”, “RWD” or “AWD”)

               """
        self.car_code = car_code
        self.car_name = car_name
        self.car_capacity = car_capacity
        self.car_horsepower = car_horsepower
        self.car_weight = car_weight
        self.car_type = car_type

    def __str__(self):
        """
              Returns:
               A formatted string containing car details
        """
        formatted_str = f'"{self.car_code}, {self.car_name}, {self.car_capacity}, {self.car_horsepower}, {self.car_weight}, {self.car_type}"'
        return formatted_str

    def probationary_licence_prohibited_vehicle(self):
        """method to check whether the vehicle is a prohibited vehicle for probationary licence drivers or not

            Returns: True (for a car with a Power to Mass ratio greater than 130 kilowatt
                     per tonne is a prohibited vehicle for probationary licence drivers)

                     False(for a car with a Power to Mass ratio lesser than/equal to  130 kilowatt)
        """
        try:
            #formula to calculate power to mass ratio
            #power to mass ratio is rounded upto 3 decimal points
            power_to_mass_ratio = round(self.car_horsepower / self.car_weight, 3) * 1000
            return power_to_mass_ratio > 130

        # to handle division by zero exception
        except ZeroDivisionError as e:
            print("Car weight cannot be zero for power-to-mass ratio calculation. As",e,"is not allowed")
            return False

    def found_matching_car(self,car_code):
        """method to check whether the current vehicle is the one to be found based on a car_code.

         Parameter : car_code to match

         Returns: True (if the car_code matches the current car’s car_code)
                 False (if the car_code does not match the current car’s car_code)
        """
        if self.car_code == car_code.upper():
            return True
        else:
            return False

    def get_car_type(self):
        """method to get the car_type.
          Returns: car_type
        """
        return self.car_type.upper()












