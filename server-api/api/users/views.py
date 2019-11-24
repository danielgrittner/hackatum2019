from django.shortcuts import render
from rest_framework import generics
from rest_framework.response import Response
from .db import beacon_user, pos_user
from .models import BeaconUser, PosUser
from .utils import *
import json
import uuid


class GetBeaconUser(generics.ListCreateAPIView):
    def get(self, request, email):
        print("MAKING API CALL")  # FIXME:
        data = get_beacon_user(email)
        print("DATA: {}".format(data))  # FIXME:
        return Response({"user": data})


class CreateBeaconUser(generics.ListCreateAPIView):
    def post(self, request):
        """
            Creates a beacon user

            Body-Schema:
            {
                "name": <name>,
                "email": <email>,
                "disabilities": <disabilities>[]
            }
        """
        print("REQUEST.BODY: {}".format(request.body))  # FIXME:
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)

        name = body["name"]
        disabilities = body["disabilities"]
        email = body["email"]

        result = create_beacon_user(name, email, disabilities)

        print("BODY: {}".format(body))  # FIXME:

        return Response({"result": True})


class UpdateBeaconUserDisabilities(generics.ListCreateAPIView):
    def post(self, request):
        """
            Updates the disabilities of a user. The current disabilities will be entirely replaced
            by the given disabilities-list

            Body-Schema:
            {
                "id": <user-id>,
                "disabilities": <disabilities>[]
            }
        """
        print("REQUEST.BODY: {}".format(request.body))  # FIXME:
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)

        print("BODY: {}".format(body))  # FIXME:

        beacon_user_id = body["id"]
        updated_disabilities = body["disabilities"]

        result = update_beacon_user_disabilities(
            beacon_user_id, updated_disabilities)

        return Response({"result": True})


class SendBeaconLocation(generics.ListCreateAPIView):
    def post(self, request, beacon_id, beacon_user_id, beacon_state):
        beacon_state = int(beacon_state, 10)

        result = {}
        if beacon_state < 3:
            result = manage_beacon_user_in_queue(
                beacon_id, beacon_user_id, beacon_state)
        else:
            result = remove_beacon_user_from_queue(beacon_id, beacon_user_id)

        print("RESULT: {}".format(result))  # FIXME:

        return Response({"beacon": result})


class GetEnqueuedBeaconUsers(generics.ListCreateAPIView):
    def get(self, request, beacon_id):
        return Response({"beacon_users": get_enqueued_beacon_users(beacon_id)})
