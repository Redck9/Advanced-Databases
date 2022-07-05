import csv
import numpy as np
import json

reader = csv.reader(open('C://Users//winga//Desktop//CODE_GROUP18 (1)//CODE_GROUP18//MONGODB//json_files//CSVS//members.csv'))
    
result = []
j = -1

#add values to each attribute of the document
def document(row):
    row["member_id"] = i[4]
    row["member_uri"] = i[1]
    row["name"] = None
    row["current_member"] = i[3]
    row["band_id"] = i[0]

for i in reader:
    member_id = i[4]
    #do nothing at the first line of csv
    if(j == -1):
        j = 0
    #second row of csv
    elif(j == 0):
        row = {}
        names = []
        document(row)
        names.append(i[2])
        result.append(row)
        j = 1
    #when there is multiple rows with the same member_id    
    elif(member_id == row["member_id"]):
        #add to the array the name of the member
        names.append(i[2])
    #new member_id
    else:
        #add the array to attribute name of the previous document
        row["name"] = names

        row = {}
        names = []
        document(row)
        names.append(i[2])
        result.append(row)
    
#add the array to attribute name    
row["name"] = names


#write to json file
with open("/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/documents/members.json", "w") as outputFile:
     json.dump(result, outputFile)

#print(len(result))
