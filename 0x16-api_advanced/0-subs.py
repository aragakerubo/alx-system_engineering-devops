#!/usr/bin/python3
import requests


def number_of_subscribers(subreddit):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
                Chrome/91.0.4472.124 Safari/537.36"
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
