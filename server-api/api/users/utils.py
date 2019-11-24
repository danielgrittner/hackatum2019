from .db import pos_user, beacon_user
import heapq
import uuid


def get_enqueued_beacon_users(beacon):
    """
        Returns all the enqueued beacon users
    """
    db_response_pos_user = pos_user.find_one({"beacon_id": beacon})
    beacon_queue = db_response_pos_user["queue"]

    # Query all the enqueued beacon users from the DB with all the necessary information
    beacon_users_sorted = []
    for _, beacon_user_id in beacon_queue:
        beacon_usr = beacon_user.find_one({"id": beacon_user_id})

        if beacon_usr["_id"]:
            del beacon_usr["_id"]

        beacon_users_sorted.append(beacon_usr)

    return beacon_users_sorted


def manage_beacon_user_in_queue(beacon, beacon_user_id, beacon_state):
    """
      Enqueues a beacon user into a beacon queue and saves it back to the database
    """
    print("CHECKING FOR BEACON-ID: {}".format(beacon))

    db_response = pos_user.find_one({"beacon_id": beacon})
    beacon_name = db_response["beacon_name"]
    queue = [(priority, beacon_uid)
             for priority, beacon_uid in db_response["queue"]]

    if len([(priority, beacon_uid) for priority, beacon_uid in queue if beacon_uid == beacon_user_id]) == 0:
        # insert completely new entry
        queue.append((beacon_state, beacon_user_id))
        heapq.heapify(queue)
    else:
        # update the priority of an existing entry
        queue = [(beacon_state, beacon_uid) if beacon_uid == beacon_user_id else (
            prio, beacon_uid) for prio, beacon_uid in queue]
        heapq.heapify(queue)

    pos_user.update_one({"beacon_id": beacon}, {"$set": {"queue": queue}})

    return beacon_name


def get_next_full_beacon_user(beacon_id):
    """
        Fetches the complete next beacon user from the beacon queue
    """
    db_response = pos_user.find_one({"beacon_id": beacon_id})
    queue = db_response["queue"]
    next_beacon_user_id = queue[0] if len(queue) > 0 else ""

    if next_beacon_user_id == "":
        return {}

    next_beacon_user = beacon_user.find_one({"id": next_beacon_user_id[1]})

    if next_beacon_user is None:
        return {}

    if next_beacon_user["_id"] is not None:
        del next_beacon_user["_id"]

    return next_beacon_user


def get_next_beacon_user(beacon_id):
    """
      Returns the next beacon user for a certain beacon queue
    """
    db_response = pos_user.find_one({"beacon_id": beacon_id})
    queue = db_response["queue"]
    return queue[0] if len(queue) > 0 else ""


def remove_beacon_user_from_queue(beacon, beacon_user_id):
    """
      Removes a beacon user from a beacon queue and saves it back to the database
    """
    db_response = pos_user.find_one({"beacon_id": beacon})
    queue = [(priority, beacon_uid)
             for priority, beacon_uid in db_response["queue"] if beacon_user_id != beacon_uid]
    heapq.heapify(queue)

    pos_user.update_one({"beacon_id": beacon}, {"$set": {"queue": queue}})

    return ""


def create_beacon_user(name, email, disabilities):
    """
        Creates a beacon user DB entry
    """
    new_user = {
        "id": uuid.uuid1().__str__(),
        "name": name,
        "email": email,
        "disabilities": disabilities
    }

    return beacon_user.insert_one(new_user)


def get_beacon_user(email):
    """
        Fetches a beacon user via email
    """
    data = beacon_user.find_one({"email": email})
    if data["_id"]:
        del data["_id"]

    return data


def update_beacon_user_disabilities(beacon_user_id, updated_disabilities):
    """
        Updates the beacon user disabilities
    """
    return beacon_user.find_one_and_update({"id": beacon_user_id}, {"$set": {"disabilities": updated_disabilities}})
