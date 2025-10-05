import os
import requests
from datetime import datetime


class Tools:
    def __init__(self):
        pass

    def calculator(self, equation: str) -> str:
        """Calculate the result of an equation.
        :param equation: The equation to calculate."""
        try:
            result = eval(equation)
            return f"{equation} = {result}"
        except Exception as e:
            print(e)
            return "Invalid equation"
