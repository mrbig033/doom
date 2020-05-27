#!/usr/bin/env python3

import json
import atexit
from os import system


class NowTasks:
    def __init__(self, state: list = ["", "", ""]):
        self.state = state

    def run(self):

        system("clear")

        while True:
            self._get_input()
            self._set_before()
            atexit.register(self.exit_handler)

    def _get_input(self):
        try:
            self.state[0] = input(">> ")

            if self.state[0] == "q".lower():
                print("\rDone!")
                exit()

        except (EOFError, KeyboardInterrupt):
            print("\rDone!")
            exit()

    def _set_before(self):
        system("clear")
        self._output_string()
        self.state[2] = self.state[1]
        self.state[1] = self.state[0]

    def _output_string(self):
        if self.state[1] != "":
            print(f"## NOW: {self.state[0]} ##\n## BEFORE: {self.state[1]} ##")
        else:
            print(f"## NOW: {self.state[0]} ##\n## BEFORE: Empty ##")

    def _write_json(self):
        self.json_data = [self.state[2], self.state[1]]
        with open("now.json", "w") as f:
            json.dump(self.json_data, f)

    def exit_handler(self):
        self._write_json()

    def _load_json(self):
        try:
            with open("now.json") as f:
                self.json_data = json.load(f)
        except (EOFError, KeyboardInterrupt):
            self._write_json()


if __name__ == "__main__":
    now = NowTasks()
    now.run()
