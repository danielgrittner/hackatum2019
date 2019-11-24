import json
import asyncio
from django.conf import settings
from asgiref.sync import sync_to_async
from channels.generic.websocket import AsyncJsonWebsocketConsumer

from .utils import *


# TODO: get the beacon id from the websocket connection establishment
class BeaconUserIdConsumer(AsyncJsonWebsocketConsumer):
    async def websocket_connect(self, event):
        """
          Called when the websocket is handshaking as part of initial connection
        """
        # TODO: for now allow every connection
        print("\n\n\nHEEELLLOOOO")  # FIXME:
        beacon_id = self.scope["url_route"]["kwargs"]["beacon_id"]
        print("BEACON_ID: {}".format(beacon_id))  # FIXME:

        await self.accept()

        # # FIXME:
        while True:
            await asyncio.sleep(1)  # FIXME:

            next_beacon_user = await sync_to_async(get_next_full_beacon_user)(beacon_id)

            print("NEXT_BEACON_USER: {}".format(next_beacon_user))  # FIXME:

            await self.send_json({"type": "websocket.send", "data": next_beacon_user})

    async def websocket_receive(self, text_data=None, bytes_data=None):
        # TODO: Test
        print("\n\nHEEEELLLOOO")  # FIXME:
        await self.send("Hello Client!")

    async def websocket_disconnect(self, event):
        """
          Called when the websocket closes for any reason
        """
        await self.send({
            "type": "websocket.send",
            # "text": event["text"]
        })
