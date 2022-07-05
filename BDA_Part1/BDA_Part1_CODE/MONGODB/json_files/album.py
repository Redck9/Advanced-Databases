import csv
import numpy as np
import json

reader = csv.reader(open('albuns.csv'))
    
result = []
j = -1

#add values to each attribute of the document
def document(row, band):
    row["album_id"] = i[0]
    row["album_name"] = i[1]
    row["release_date"] = i[2]
    row["sales_amount"] = i[3]
    row["running_time"] = i[4]
    band["band_name"] = i[5]
    row["band"] = band


for i in reader:
    album_id = i[0]
    #do nothing at the first line of csv
    if(j == -1):
        j = 0
    #second row of csv
    elif(j == 0):
        row = {}
        band = {}
        genre = []
        document(row, band)
        genre.append(i[6])
        result.append(row)
        j = 1
    #when there is multiple rows with the same album id
    elif(album_id == row["album_id"]):
        #add to the array the genre of the band
        genre.append(i[6])
    #new album id
    else:
        #add the array to attribute band_genre of the previous document
        band["band_genre"] = genre
        
        row = {}
        band = {}
        genre = []
        document(row, band)
        genre.append(i[6])
        result.append(row)
    

band["band_genre"] = genre

#write to json file
with open("/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/documents/album.json", "w") as outputFile:
     json.dump(result, outputFile)

#print(len(result))