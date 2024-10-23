#!/usr/bin/env python3
""" This Python function lists all documents in a colletion """


def list_all(mongo_collection):
    """This function lists all documents in a collection
       and lists all documents in the collection or an
       empty list if no documents are found
    """
    return list(mongo_collection.find())
