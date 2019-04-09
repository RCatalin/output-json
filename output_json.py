import errno
import json
import os
import socket
from builtins import print
from random import randint
from datetime import datetime
from time import sleep

VERSION = None


def create_data():
    words = ["X-ray", "cassette", "eat", "financial", "drum", "tool", "grand", "import", "seize", "needle", "liability",
             "resignation", "unlawful", "haunt", "decay", "chauvinist", "commemorate", "camp", "plug", "overeat", "bar",
             "", "climate", "park", "rifle", "swop", "count", "respect", "pony", "cable", "step", "concede", "money",
             "smoke", "meal", "retreat", "representative", "rocket", "feed", "slow", "abstract", "dirty", "employ",
             "conversation", "beg", "sheep", "makeup", "sum", "chart", "project", "approve"]

    colours = ["red", "green", "blue", "black", "yellow", "orange"]

    random_int = randint(0, 5)
    print("Random int value: %s" % random_int)

    entry = {'colour': colours[random_int], 'hostname': socket.gethostname(), 'version': VERSION,
             'timestamp': str(datetime.now())}

    # Will create a child element with elements nr = random_int
    words_entry = {}
    for x in range(random_int):
        random_words_int = randint(0, 49)
        words_entry.update({str(x): words[random_words_int]})

    entry.update({'words': words_entry})

    return entry


def add_json_to_file():
    entry = create_data()

    filename = "/test/output-json.log"

    if not os.path.exists(os.path.dirname(filename)):
        try:
            os.makedirs(os.path.dirname(filename))
        except OSError as exc:  # Guard against race condition
            if exc.errno != errno.EEXIST:
                raise

    with open(filename, mode='a+') as json_file:
        json_file.write(json.dumps(entry, indent=4) + "\n")


def main():
    global VERSION
    f = open("VERSION", "r")
    VERSION = f.read()

    try:
        while True:
            sleep(1)
            add_json_to_file()

    except KeyboardInterrupt:

        print("kthxbye")


if __name__ == '__main__':
    main()
