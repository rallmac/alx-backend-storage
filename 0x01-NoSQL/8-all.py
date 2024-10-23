#!/usr/bin/env python3

""" This Python function lists all documents in a colletion """

def list_all(mongo_collection):
	return list(mongo_collection.find({}) or []
