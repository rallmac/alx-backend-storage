#!/usr/bin/env python3
""" This python function changes all topics of a school
    document based on the name
"""


def update_topics(mongo_collection, name, topics):
    """
    Changes all topics of a school document based on the name.
    
    Parameters:
    - mongo_collection: the pymongo collection object
    - name: the school name to update (string)
    - topics: list of strings representing the new topics
    """
    mongo_collection.update_many(
        { "name": name },  # Filter by school name
        { "$set": { "topics": topics } }  # Update topics
    )
