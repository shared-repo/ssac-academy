class ContentBasedMovieRecommender:

    def __init__(self):
        import numpy as np
        import pandas as pd

        genre_sim_sorted_ind = np.load('outputs/genre_sim_sorted_ind.npy')
        self.genre_sim_sorted_ind = genre_sim_sorted_ind

        weighted_movie = pd.read_csv('data-files/weighted_movie.csv')
        self.weighted_movie = weighted_movie

        pass