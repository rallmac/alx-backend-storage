#!/usr/bin/env python3
"""This python function inserts a new document in a collection
   based on keyword arguments
"""


def insert_school(mongo_collection, **kwargs):
    """
    Inserts a new document into the school collection based on kwargs.

    Parameters:
    - mongo_collection: the pymongo collection object
    - kwargs: key-value pairs representing the fields and their
      values for the document

    Returns:
    - The _id of the newly inserted document
    """
    result = mongo_collection.insert_one(kwargs)
    return result.inserted_id
