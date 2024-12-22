
def get_items (name):
    path = "../data/"
    items = None
    with open(f"{path}raw/{name}.txt") as file:
        items = file.read()
        items = items.split("\n")
        items = [i.strip() for i in items]
    return items

def equality (l1, l2):
    equal = 0
    for i in l1:
        for j in l2:
            if i == j:
                equal +=1
    return equal

produce = get_items("produce")
purchase = get_items("purchase")
inventory = get_items("inventory")

print(equality(produce, purchase))
print(equality(produce, inventory))
print(equality(purchase, inventory))