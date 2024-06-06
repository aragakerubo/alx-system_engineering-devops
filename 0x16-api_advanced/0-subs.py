#!/usr/bin/python3
"""Queries Reddit API and returns the number of subscribers"""
import requests


def number_of_subscribers(subreddit):
    headers = {
        "User-Agent": "Linux: 0x16. API advanced v1.0 by u/devara"
    }
    url = f"https://www.reddit.com/r/{subreddit}/about.json"

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)

        if response.status_code == 200:
            data = response.json()
            return data["data"]["subscribers"]
        elif response.status_code == 302:  # Redirect means invalid subreddit
            return 0
        else:
            return 0
    except requests.RequestException:
        return 0


# Example usage:
# print(
#     number_of_subscribers("python")
# )  # Should return the number of subscribers for the 'python' subreddit
# print(
#     number_of_subscribers("thissubredditdoesnotexist")
# )  # Should return 0 for an invalid subreddit
