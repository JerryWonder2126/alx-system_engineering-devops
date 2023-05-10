#!/usr/bin/python3
"""Queries the Reddit API and prints the titles of
the first 10 hot posts listed for a given subreddit"""

import requests


def top_ten(subreddit):
    """
    Queries the Reddit API and prints the titles of
    the first 10 hot posts listed for a given subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {
        "User-Agent": "Mozilla/5.0"
    }
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        body = response.json().get("data")
        for value in body.get("children")[:10]:
            print(value["data"]["title"])
    else:
        print("None")
