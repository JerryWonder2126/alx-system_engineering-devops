#!/usr/bin/python3
"""recursively queries the Reddit API and returns a list containing
the titles of all hot articles for a given subreddit"""

import requests


def recurse(subreddit, hot_list=[], after=0):
    """
    recursively queries the Reddit API and returns a list containing
    the titles of all hot articles for a given subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "Mozilla/5.0"}
    params = {"t": "all", "after": after}
    response = requests.get(url, headers=headers,
                            params=params, allow_redirects=False)
    if response.status_code != 200:
        return None
    body = response.json().get("data")
    for value in body.get("children"):
        title = value.get("data").get("title")
        hot_list.append(title)
    after = body.get("after")
    if after:
        recurse(subreddit, hot_list, after)
    return hot_list
