import csv

#open the userreviews file which was renamed to Resit.csv
file = csv.reader(open('/Users/kevinseegers/Desktop/Resit.csv', encoding = 'utf8'),delimiter = ';')

data = list(file)

#print(data)

#make a sbubset of the data that focusses on my second favorite movie intersteller
#(second fav. since first one was done in the first reccomender system)
subset = list()
for movie in data:
    if movie[0] == 'interstellar':
        subset.append(movie)
        #print(subset)

#make a list for the recommendations file
recommendations = list()
#here we calculate the absolute & relative increase
for movie in subset:
   for y in data:
       if movie[2] == y[2] and int(movie[1]) > 7 and int(y[1]) >= int(movie[1]):
            abs_inc = int(y[1]) - int(movie[1])
            rel_inc = (int(y[1]) - int(movie[1])) / int(movie[1])
            recommendation = (y[0], y[1], y[2], y[3], y[4], y[5], y[6], y[7], y[8], y[9], abs_inc, rel_inc)
            recommendations.append(recommendation)
            #print(recommendations)

sortedrecommendations = sorted(recommendations, key=lambda tup: (tup[11]), reverse=True)
#print(sortedrecommendations)

csvwriter = csv.writer(open("test.csv", "w"))
for row in sortedrecommendations:
    csvwriter.writerow(row)

#naming the columns so i know what i'm working with
column_names = ['movieName','Metascore_w','Author','AuthorHref','Date','Summary','InteractionsYesCount','InteractionsTotalCount','InteractionsThumbUp','InteractionsThumbDown']

with open('/Users/kevinseegers/PycharmProjects/FundaProject/venv/test.csv', "w", newline='')as resit:
    writer = csv.writer(resit, delimiter = ';')
    writer.writerow(column_names)

#main recommendation csv file
    for row in sortedrecommendations:
        writer.writerow(row)






