import re

# I know what you're thinking and no, it doesn't work if I don't do this
words_to_int = {
    "1": "1",
    "2": "2",
    "3": "3",
    "4": "4",
    "5": "5",
    "6": "6",
    "7": "7",
    "8": "8",
    "9": "9",
    "0": "0",
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
    "zero": "0"
}

with open("input.txt", "r") as file:
    # Funky regex time (I am truly sorry)
    pattern = re.compile(r"(?=(" + "".join([x + "|" for x in words_to_int.keys()])[:-1] + "))")

    digit_matches = [re.finditer(pattern, line) for line in file]
    digit_sets = [[words_to_int[x.group(1)] for x in y] for y in digit_matches]
    digit_pairs = [(int(x[0]) * 10, int(x[-1])) for x in digit_sets]
    digit_totals = [sum(x) for x in digit_pairs]
    totals = sum(digit_totals)
    print(totals)