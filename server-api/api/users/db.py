import pymongo
import ssl

client = pymongo.MongoClient(
    "mongodb+srv://curic-backend:Password123@hackertum2019cluster-3vubn.mongodb.net/test?retryWrites=true&w=majority", ssl=True, ssl_cert_reqs=ssl.CERT_NONE)

print(client.list_database_names())

db = client["CuricDB"]

beacon_user = db["BeaconUser"]
pos_user = db["POSUser"]
