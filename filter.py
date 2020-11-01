#using Panda as the data analysis tool
import pandas as pd

#data is a dataframe -> importing datafile
data = pd.read_csv('userReviews.csv',sep=',')

#print(data.head())
#print(data[:3])
#print(data.movieName.iloc[1])

#naming the columns so i know what i'm working with
colum_names = ['movieName','Metascore_w','Author','AuthorHref','Date','Summary','InteractionsYesCount','InteractionsTotalCount','InteractionsThumbUp','InteractionsThumbDown' ]

#creating empty dataframe with the same columns as userreview set
subset = pd.DataFrame(columns = colum_names)

#filtering the wanted movie beach rats
#for movie in range(100):
    #if data.movieName.iloc[movie] == 'the-social-network':
        #row=data[movie:movie +1]
        #print(row)
        #subset.append
        

#changing the looping filter above with a faster filtering method
for movie in range(len(data.movieName)):
    if data.movieName.iloc[movie] == 'the-social-network':
        row = data[movie:movie+1]
        subset = subset.append(row)


#creating subset with reviews on favorite movie (the social network)
subset = data[data.movieName == 'the-social-network']

#Creating a subset were we calculate the movies with relative and absolute difference in score
recommendations = pd.DataFrame(columns=data.columns.tolist()+['rel_inc','abs_inc'])

#loop over all the reviewers that commented on my fovorite movie
for idx, Author in subset.iterrows():
    
    #saving the name of the author and the score he gave to "the social network"
    author = Author[['Author']].iloc[0]
    ranking = Author[['Metascore_w']].iloc[0]
    
    #creating a dataframe of movies that were better rated than my favorite movie by authors
    #including the percentual and absolute difference between the scores
    #setting filters
    filter1 = (data.Author==author)
    filter2 = (data.Metascore_w>ranking)
    
    #Getting the reccomended movies based upon rankings by authors
    possible_recommendations = data[filter1 & filter2]
    
    possible_recommendations.loc[:,'rel_inc'] = possible_recommendations.Metascore_w / ranking
    possible_recommendations.loc[:,'abs_inc'] = possible_recommendations.Metascore_w - ranking
    
    #adding it to the recommendations dataframe
    recommendations = recommendations.append(possible_recommendations)
    
#putting the reccomendations in order (high-low) with the relative and absolute difference
recommendations = recommendations.sort_values(['rel_inc','abs_inc'], ascending=False)

#drop duplicates by other authors to keep the file clean
recommendations = recommendations.drop_duplicates(subset='movieName', keep="first")

#putting the top 50 results in a .csv file
recommendations.head(50).to_csv("recommendationsfromPython.csv", sep=";", index=False)

print(recommendations.head(50))