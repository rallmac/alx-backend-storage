#!/usr/bin/env python3
"""This script implemens an expiring web cache and tracker
"""

import redis
import requests
from typing import Callable
from functools import wraps


r = redis.Redis()


def count_requests(method: Callable) -> Callable:
    """Decorator to count how many times a URL has
       been accessed.
    """
    @wraps(method)
    def wrapper(url: str) -> str:
        cache_key = f"count:{url}"
        r.incr(cache_key)
        return method(url)
    return wrapper


def cache_page(method: Callable) -> Callable:
    """Decorator to cache a page for 10 seconds."""
    @wraps(method)
    def wrapper(url: str) -> str:
        cache_key = f"cached:{url}"
        cached_content = r.get(cache_key)
        if cached_content:
            return cached_content.decode('utf-8')

        content = method(url)
        r.setex(cache_key, 10, content)
        return content
    return wrapper


@count_requests
@cache_page
def get_page(url: str) -> str:
    """Fetch HTML content of a URL and cache the
       result.
    """
    response = requests.get(url)
    return response.text
