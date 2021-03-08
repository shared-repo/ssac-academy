class ContentBasedMovieRecommender:

    def __init__(self):
        import numpy as np
        import pandas as pd

        genre_sim_sorted_ind = np.load('outputs/genre_sim_sorted_ind.npy')
        self.genre_sim_sorted_ind = genre_sim_sorted_ind

        weighted_movie = pd.read_csv('data-files/weighted_movie.csv')
        self.weighted_movie = weighted_movie

    def find_sim_movie(self, title, top_n=10):
        title_movie = self.weighted_movie[self.weighted_movie['title'] == title]
        title_index = title_movie.index.values
        
        # top_n의 2배에 해당하는 쟝르 유사성이 높은 index 추출 
        similar_indexes = self.genre_sim_sorted_ind[title_index, :(top_n*2)]
        similar_indexes = similar_indexes.reshape(-1)

        # 기준 영화 index는 제외
        similar_indexes = similar_indexes[similar_indexes != title_index]
        
        # top_n의 2배에 해당하는 후보군에서 weighted_vote 높은 순으로 top_n 만큼 추출 
        return self.weighted_movie.iloc[similar_indexes].sort_values('weighted_vote', ascending=False)[:top_n]

if __name__ == "__main__": # python content_based_movie_recommender.py 형식으로 실행한 경우 ( import content_based_movie_recommender 로 실행한 경우에는 실행되지 않는 영역)

    recommender = ContentBasedMovieRecommender()

    while True:
        title = input("Input Movie Title (Enter for Quit) : ")
        
        if title is None or len(title) == 0:
            break

        try:
            top_n_movies = recommender.find_sim_movie(title)
            print("[ RECOMMENDED MOVIES ]")
            print(top_n_movies[['title', 'vote_average', 'weighted_vote']])
        except:
            print("Fail to Recommend !!!!")
