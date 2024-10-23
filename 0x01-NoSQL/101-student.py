#!/usr/bin/env python3
"""This python function returns all students sorted by average
   score
"""


def top_students(mongo_collection):
    """
    Returns all students sorted by average score.
    Each student document includes an 'averageScore' key.
    """
    # Pipeline to calculate the average score and sort by it
    pipeline = [
        {
            "$addFields": {
                "averageScore": { "$avg": "$topics.score" }
            }
        },
        {
            "$sort": { "averageScore": -1 }
        }
    ]

    # Use aggregation pipeline to get the results
    return list(mongo_collection.aggregate(pipeline))
