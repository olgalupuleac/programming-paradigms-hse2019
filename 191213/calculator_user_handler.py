import re
from bot import UserHandler


class CalculatorUserHandler(UserHandler):
    OPERATIONS = {
        '+': lambda a, b: a + b,
        '-': lambda a, b: a - b,
        '*': lambda a, b: a * b,
        '/': lambda a, b: a // b
    }

    def handle_message(self, message: str) -> None:
        a, op, b = message.split()
        self.send_message(str(self.OPERATIONS[op](int(a), int(b))))
