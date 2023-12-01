# Yes I know, very boring python solution
# I might try to solve these in something weirder later in the challenge
with open("input.txt", "r") as file:
    lines = [x for x in file]
    digit_sets = [[x for x in line if x.isdigit()] for line in lines]
    digit_pairs = [(int(x[0]) * 10, int(x[-1])) for x in digit_sets]
    digit_totals = [sum(x) for x in digit_pairs]
    totals = sum(digit_totals)
    print(totals)