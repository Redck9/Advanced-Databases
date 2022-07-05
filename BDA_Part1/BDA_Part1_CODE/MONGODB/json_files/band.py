import csv
import numpy as np
import json

reader = csv.reader(open('band.csv'))
    
result = []
j = -1

#add values to each attribute of the document
def document(row, members):
    row["band_id"] = i[0]
    row["band_uri"] = i[1]
    row["band_name"] = i[2]
    row["band_genre"] = None
    row["members"] = members


for i in reader:
    idx = i[0]
    #do nothing at the first line of csv
    if(j == -1):
        j = 0
    #second row of csv    
    elif(j == 0):
        row = {}
        members = {}
        genre = []
        members_id = []
        document(row, members)
        genre.append(i[3])
        members_id.append(i[4])
        result.append(row)
        j = 1
    #when there is multiple rows with the same band_id    
    elif(idx == row["band_id"]):
        #add to the array the genre of the band
        genre.append(i[3])
        #add to the array the id of the member
        members_id.append(i[4])
    #new band_id
    else:
        #remove duplicate values
        genre = list(set(genre))
        members_id = list(set(members_id))

        #add the arrays to respective attributes of the previous document
        row["band_genre"] = genre
        members["members_id"] = members_id

        row = {}
        members = {}
        genre = []
        members_id = []
        document(row, members)
        genre.append(i[3])
        members_id.append(i[4])
        result.append(row)

#remove duplicate values    
genre = list(set(genre))
members_id = list(set(members_id))

#add the arrays to respective attributes
row["band_genre"] = genre
members["members_id"] = members_id

#write to json file
with open("/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/documents/bands.json", "w") as outputFile:
     json.dump(result, outputFile)

#print(len(result))