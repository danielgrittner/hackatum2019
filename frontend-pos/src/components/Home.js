import React, { useState, useEffect } from "react";
import { Typography, Container, Grid } from "@material-ui/core";
import AttentionCard from "./AttentionCard";

const BEACON_ID = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";

/*
const useStyles = makeStyles(theme => ({
  container: {
    display: 'grid',
    gridTemplateColumns: 'repeat(12, 1fr)',
    gridGap: theme.spacing(3),
    //maxWidth: 50%,
    backgroundColor: '#F8F8F8',
  },
*/

//(AttentionCard) &&
const Home = () => {
  const [websocket, setWebsocket] = useState(null);
  const [userData, setUserData] = useState(null);

  const connect = () => {
    const ws = new WebSocket(
      `ws://192.168.8.113:8000/beacon-queue/${BEACON_ID}`
    );

    ws.onopen = () => {
      setWebsocket(ws);
    };

    ws.onmessage = e => {
      const beaconUserData = JSON.parse(e.data);
      const realData = beaconUserData.data;
      setUserData(realData);
      console.log(`USER_DATA: ${JSON.stringify(realData)}`); // FIXME
    };

    ws.onclose = () => {
      setWebsocket(null);
      setUserData(null);
    };
  };

  useEffect(() => {
    if (!websocket) {
      connect();
    }
  });

  // console.log(`USER_DATA: ${JSON.stringify(userData)}`);

  return (
    <Grid
      container
      style={{ width: "100%", minHeight: 620, backgroundColor: "blue" }}
    >
      {userData && userData !== {} && (
        <Grid
          item
          alignItems={"flex-start"}
          style={{ marginTop: "auto", marginLeft: "1%", marginBottom: "1%" }}
        >
          <AttentionCard beaconUserData={userData} />
        </Grid>
      )}
      <Grid
        item
        alignItems={"flex-end"}
        style={{ backgroundPosition: "center", backgroundSize: "cover" }}
      >
        <img src="https://ak0.picdn.net/shutterstock/videos/1031472830/thumb/1.jpg?ip=x480" />
      </Grid>
    </Grid>
  );
};

export default Home;
