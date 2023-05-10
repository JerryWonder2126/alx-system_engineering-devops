#!/usr/bin/python3
# Returns the number of subscriber to a subreddit

import requests


def number_of_subscribers(subreddit):
    """"
    Returns the number of subscriber to a subreddit
    Returns 0 if the subreddit isn't valid
    """
    url = "https://redit.com/r/{}/about.json".format(subreddit)
    headers = {
        "User-Agent": "ubuntu22.04 - Jerry Wonder"
    }
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 404:
        return 0
    subscribers = response.json()["data"]["subscribers"]
    return subscribers
