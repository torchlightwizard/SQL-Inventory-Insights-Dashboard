import pandas as pd

def get_dic (df):
    dic = {}
    for x in df.iterrows():
        if not x[1].iloc[0] in dic:
            dic[x[1].iloc[0]] = []
        dic[x[1].iloc[0]].append(x[1].iloc[1])
    return dic

def yaml_dic (dic):
    s = ""
    for key in dic:
        s = s + key + ": " + str(dic[key]) + "\n"
        s = s.replace("'", "")
    return s

def csv_to_yaml (name):
    path = "../data/"
    file_name = f"{path}raw/{name}.txt"
    df = pd.read_csv(file_name)
    dic = get_dic(df)
    yaml = yaml_dic(dic)
    with open(f"{path}processed/{name}.yaml", "w") as file:
        file.write(yaml)

csv_to_yaml("production")
csv_to_yaml("sales")
csv_to_yaml("purchasing")