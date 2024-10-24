#!/usr/bin/env python3
""" This module creates a cache class """

import redis
import uuid
from typing import Union


class Cache:
    """Here the class is being declared
    """
    def __init__(self):
        """Initialize the Cache class.
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """Store the data in Redis with a random key and
           return the key.
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key
