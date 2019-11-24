from django.conf.urls import url
from django.urls import re_path

from channels.http import AsgiHandler
from channels.routing import ProtocolTypeRouter, URLRouter

import users.routing

print("HERE: {}".format(users.routing.websocket_urlpatterns))  # FIXME:

application = ProtocolTypeRouter({
    "websocket": URLRouter(
        users.routing.websocket_urlpatterns
        # url(
        #     r'^beacon-queue/(?P<beacon_id>[\w\-])$', BeaconUserIdConsumer)
    ),
})
