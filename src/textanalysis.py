#!usr/bin/python
__author__ = 'Vishal Taj'

from string import punctuation
import urllib
import bottle
from bottle import route, static_file
import cgi
import re



@route('<path:path>')
def serve_static(path):
    return static_file(path, root='./static/')

def words_in_string(word_list, a_string):
    return set(word_list).intersection(a_string.split())

@bottle.route('/')
def home_page():
    tweets = open('Mr.X_tweets.txt').read()
    tweet_list = tweets.split('\n')
    positive_sentimental = open('positive.txt').read()
    positive_words = positive_sentimental.split('\n')
    negative_sentimental = open('negative.txt').read()
    negative_words = negative_sentimental.split('\n')
    print positive_words[:10]
    positive_counter=0
    negative_counter = 0
    emotion_counter = 0
    no_comments = 0
    for tweet in tweet_list:
        pflag = 0
        nflag = 0
        tweet_processed = tweet.lower()
        for p in punctuation:
            tweet_processed = tweet_processed.replace(p,'')
        if words_in_string(positive_words,tweet_processed):
            pflag = 1

        if words_in_string(negative_words,tweet_processed):
            nflag = 1

        if pflag == 1 and nflag == 1:
            emotion_counter = emotion_counter + 1
        elif pflag == 1:
            positive_counter = positive_counter + 1
        elif nflag == 1:
            negative_counter = negative_counter + 1
        else:
            no_comments = no_comments + 1
    return bottle.template('index', {'positive': positive_counter,'negative': negative_counter,'partial':emotion_counter,'nocomments':no_comments})

bottle.debug(True)
bottle.run(host='localhost', port=8082)
