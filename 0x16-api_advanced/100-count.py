#!/usr/bin/python3
"""recursively queries the Reddit API, parses the title of all
hot articles, and prints a sorted count of given keywords"""

import requests


def count_words(subreddit, word_list, word_count={}, after=0):
    """
    recursively queries the Reddit API, parses the title of all
    hot articles, and prints a sorted count of given keywords
    """
    word_list = list(set([x.lower() for x in word_list]))
    if not len(word_count):
        word_count = {key: 0 for key in word_list}
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "Mozilla/5.0"}
    params = {"t": "all", "after": after}
    response = requests.get(url, headers=headers,
                            params=params, allow_redirects=False)
    if response.status_code != 200:
        return None
    body = response.json().get("data")
    for value in body.get("children"):
        words = value.get("data").get("title").lower().split()
        for word in words:
            if word in word_count:
                word_count[word] += 1
    after = body.get("after")
    if after:
        count_words(subreddit, word_list, word_count, after)
    else:
        word_count = dict(sorted(word_count.items(),
                                 key=lambda x: (-x[1], x[0])))
        for key, value in word_count.items():
            if value:
                print("{}: {}".format(key, value))
    return word_count
