#!/usr/bin/python3
"""Function that queries the Reddit API and returns the number of subscribers
for a given subreddit"""

import requests


def number_of_subscribers(subreddit):
    """Gets the number of subscribers for a given subreddit"""
    url = "http://reddit.com/r/{}/about.json".format(subreddit)
    headers = {"User-Agent": "Mozilla/5.0"}
    try:
        response = requests.get(url, headers=headers, allow_redirects=False)

        if response.status_code == 200:
            data = response.json()
            return data['data']['subscribers']
        else:
            return 0
    except requests.RequestException:
        return 0

print(number_of_subscribers('python'))  # Should return the number of subscribers for the 'python' subreddit
print(number_of_subscribers('thissubredditdoesnotexist'))  # Should return 0 for an invalid subreddit
