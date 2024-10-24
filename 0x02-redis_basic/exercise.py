#!/usr/bin/env python3
""" This module creates a cache class with call count,
    call history, and replay functionality.
"""

import redis
from uuid import uuid4
from typing import Any, Union, Callable, Optional
from functools import wraps


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


def call_history(method: Callable) -> Callable:
    """Decorator to store the history of inputs and
       outputs of a function.
    """
    @wraps(method)
    def wrapper(self: Any, *args, **kwargs) -> Any:
        """Wrapper function to store inputs and outputs in
           Redis lists.
        """
        input_key = f"{method.__qualname__}:inputs"
        output_key = f"{method.__qualname__}:outputs"

        self._redis.rpush(input_key, str(args))

        result = method(self, *args, **kwargs)

        self._redis.rpush(output_key, str(result))

        return result

    return wrapper


def replay(method: Callable) -> None:
    """Display the history of calls of a particular
       function.
    """
    redis_client = method.__self__._redis
    method_name = method.__qualname__

    inputs = redis_client.lrange(f"{method_name}:inputs", 0, -1)
    outputs = redis_client.lrange(f"{method_name}:outputs", 0, -1)

    call_count = len(inputs)
    print(f"{method_name} was called {call_count} times:")

    for input_data, output_data in zip(inputs, outputs):
        input_str = input_data.decode('utf-8')
        output_str = output_data.decode('utf-8')
        print(f"{method_name}(*{input_str}) -> {output_str}")


class Cache:
    """Cache class for storing data in Redis."""
    def __init__(self) -> None:
        """Initialize the Cache class."""
        self._redis = redis.Redis()
        self._redis.flushdb()

    @call_history
    @count_calls
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
