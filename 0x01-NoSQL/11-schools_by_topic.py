#!/usr/bin/env python3
"""This Python function returns a list of school having a
   specific topic
"""


def schools_by_topic(mongo_collection, topic):
    """
    Returns the list of schools that have a specific topic.

    Parameters:
    - mongo_collection: the pymongo collection object
    - topic: the topic string to search for in the school's
      topics field

    Returns:
    - A list of school documents that match the topic
    """
    return list(mongo_collection.find({"topics": topic}))
