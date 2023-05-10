#!/usr/bin/python3
""" Returns the number of subscriber to a subreddit """

import requests


def number_of_subscribers(subreddit):
    """"
    Returns the number of subscriber to a subreddit
    Returns 0 if the subreddit isn't valid
    """
    url = ("https://www.redit.com/r/{}/about.json()".format(subreddit))
    headers = {
        "User-Agent": "Mozilla/5.0"
    }
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        subscribers = response.json().get("data").get("subscribers")
        return subscribers
    return 0
