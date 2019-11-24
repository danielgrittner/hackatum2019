const connect18 = () => {
  const socket = new WebSocket(
    "ws://" +
      "192.168.8.113:8000/beacon-queue/E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
  );
  socket.onopen = () => {
    console.log("Websocket open");
  };

  socket.onmessage = e => {
    if (e.data) {
      console.log(`DATA: ${JSON.stringify(e.data)}`);
      const beaconUserData = JSON.parse(e.data);
      console.log(`PARSED_DATA: ${JSON.stringify(beaconUserData)}`);
      const realData = beaconUserData.data;
      console.log(`Name: ${realData.email}`);
      console.log(`Disabilities: ${realData.disabilities}`);
    }
    console.log(`NEW SOCKET MESSAGE: ${JSON.stringify(e)}`);
  };

  socket.onclose = () => {
    console.log("WebSocket closed!");
  };

  return socket;
};
