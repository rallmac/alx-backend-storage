#!/usr/bin/env python3
""" This module creates a cache class with call count
    functionalit
"""

import redis
from uuid import uuid4
from typing import Any, Union, Callable, Optional
from functools import wraps


class Cache:
    """Cache class for storing data in Redis.
    """
    def __init__(self) -> None:
        """Initialize the Cache class.
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """Store the data in Redis with a random key and
           return the key.
        """
        key = str(uuid4())
        client = self._redis
        client.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable] = None) -> Any:
        """Retrieve data from Redis and optionally convert
           it using a callable function.
        """
        client = self._redis
        value = client.get(key)
        if not value:
            return
        if fn is int:
            return self.get_int(value)
        if fn is str:
            return self.get_str(value)
        if callable(fn):
            return fn(value)
        return value

    def get_str(self, data: bytes) -> str:
        """Retrieve data as a UTF-8 decoded string."""
        return data.decode("utf-8")

    def get_int(self, data: bytes) -> int:
        """Retrieve data as an integer."""
        return int(data)


def count_calls(method: Callable) -> Callable:
    """Decorator to count how many times a method is called."""
    @wraps(method)
    def wrapper(self: Any, *args, **kwargs) -> str:
        """Wrapper function to increment the call count
           in Redis.
        """
        self._redis.incr(method.__qualname__)
        return method(self, *args, **kwargs)
    return wrapper
