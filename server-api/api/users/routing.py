from django.conf.urls import url
from django.urls import re_path
from .consumer import BeaconUserIdConsumer

websocket_urlpatterns = [
    url(
        r'^beacon-queue/(?P<beacon_id>[\w\-]+)$', BeaconUserIdConsumer),
    # r'^beacon-queue/(?P<beacon_id>[\w\-])$', BeaconUserIdConsumer),
]
