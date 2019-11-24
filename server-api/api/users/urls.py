from django.urls import path, re_path
from .views import GetBeaconUser, SendBeaconLocation, GetEnqueuedBeaconUsers, CreateBeaconUser, UpdateBeaconUserDisabilities

urlpatterns = [
    re_path(r'^email=(?P<email>[\w.@]+)$',
            GetBeaconUser.as_view(), name="get-user"),
    re_path(r'^beacon-update/beacon_id=(?P<beacon_id>[>[\w\-]+)/beacon_user_id=(?P<beacon_user_id>[\w\-.@]+)/beacon_state=(?P<beacon_state>\d+)$',
            SendBeaconLocation.as_view(), name="post-beacon-update"),
    re_path(r'^beacon-queue/beacon_id=(?P<beacon_id>[>[\w\-]+)$',
            GetEnqueuedBeaconUsers.as_view(), name="all-enqueud-beacon-users"),
    re_path(r'^create-beacon-user$', CreateBeaconUser.as_view(),
            name="create-beacon-user"),
    re_path(r'^update-disabilities$',
            UpdateBeaconUserDisabilities.as_view(), name="update-disabilities")
]
