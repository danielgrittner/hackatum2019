from django.conf.urls import url
from django.urls import re_path

from channels.http import AsgiHandler
from channels.routing import ProtocolTypeRouter, URLRouter

import users.routing

application = ProtocolTypeRouter({
    "websocket": URLRouter(
        users.routing.websocket_urlpatterns
    ),
})
