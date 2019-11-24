import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import { Typography, Grid, Card, Paper, ButtonBase } from "@material-ui/core";
import alertTriangle from "@material-ui/icons/PriorityHigh";
import UseAnimations from "react-useanimations";

const STRING_MAP = {
  Asthma: {
    actionItems: ["Asthma"]
  },
  Diabetes: {
    actionItems: [
      "In case of fatigue, check blood sugar",
      "Provide customer with information on bread units"
    ]
  },
  Epilepsy: {
    actionItems: [
      "Make sure that the passenger sleeps enough to reduce the probability of a seizure",
      "Check the onboard medical kit for anti-seizure medication"
    ]
  },
  Thrombosis: {
    actionItems: [
      "Encourage the customer to move around as often as possible",
      "In case, notify the customer to avoid crossing legs"
    ]
  },
  Autism: {
    actionItems: [
      "Provide separate sensory-friendly waiting room and seating",
      "Offer contingency plans for possible flight delays"
    ]
  },
  Parkinson: {
    actionItems: [
      "Offer early seating on board and to allow getting comfortable",
      "Help customer to pick an aisle seat"
    ]
  }
};

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1
  },

  container: {
    display: "grid",
    gridTemplateColumns: "repeat(12, 1fr)",
    gridGap: theme.spacing(3)
  },

  paper: {
    padding: theme.spacing(2),
    margin: "auto",
    maxWidth: 500,
    minWidth: 450,
    maxHeight: 200,
    marginBottom: theme.spacing(1),
    backgroundColor: "#C9D0E7",
    boxShadow: "0 3px 5px 2px rgba(24,24,24, .3)"
  },

  image: {
    width: 100,
    height: 100,
    borderRadius: 50
  },
  img: {
    margin: "auto",
    display: "block",
    maxWidth: 100,
    maxHeight: 100,
    borderRadius: 50
  }
}));

const renderActionItems = disabilities => {
  const actionItems = [];

  for (let i = 0; i < disabilities.length; i++) {
    for (let j = 0; j < STRING_MAP[disabilities[i]].actionItems.length; j++) {
      actionItems.push(<li>{STRING_MAP[disabilities[i]].actionItems[j]}</li>);
    }
  }

  return actionItems;
};

const AttentionCard = ({ beaconUserData }) => {
  const classes = useStyles();
  const { name, disabilities } = beaconUserData;

  if (!disabilities || !disabilities.length) {
    return null;
  }

  return (
    <div className={classes.root}>
      <Paper className={classes.paper}>
        <Grid container wrap="nowrap" spacing={2}>
          <Grid item xs={12} sm container>
            <Grid>
              <UseAnimations
                animationKey="alertOctagon"
                size={56}
                style={{
                  padding: 5,
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center"
                }}
              />
            </Grid>
            <Grid
              item
              xs
              container
              direction="column"
              justify="flex-start"
              spacing={2}
            >
              <Grid item xs>
                <Typography gutterBottom variant="subtitle1">
                  {name}
                </Typography>
                <Typography variant="body2" color="textSecondary">
                  {renderActionItems(disabilities)}
                </Typography>
              </Grid>
            </Grid>
            <Grid item>
              <Typography fontStyle="italic" variant="subtitle1">
                {disabilities.join(", ")}
              </Typography>
            </Grid>
          </Grid>
        </Grid>
      </Paper>
    </div>
  );
};

export default AttentionCard;
