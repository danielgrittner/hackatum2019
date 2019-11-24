import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import { Typography, Grid, Card, Paper, ButtonBase } from '@material-ui/core';
import alertTriangle from '@material-ui/icons/PriorityHigh';
import UseAnimations from "react-useanimations";


const STRING_MAP = {
  "Asthma": {
    
  }
};

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
  },

  container: {
    display: 'grid',
    gridTemplateColumns: 'repeat(12, 1fr)',
    gridGap: theme.spacing(3),
  },

  paper: {
    padding: theme.spacing(2),
    margin: 'auto',
    maxWidth: 500,
    maxHeight: 200,
    marginBottom: theme.spacing(1),
    backgroundColor: "#C9D0E7",
    boxShadow: '0 3px 5px 2px rgba(24,24,24, .3)'
  },

  image: {
    width: 100,
    height: 100,
    borderRadius: 50
  },
  img: {
    margin: 'auto',
    display: 'block',
    maxWidth: 100,
    maxHeight: 100,
    borderRadius: 50
  },
}));

const AttentionCard = ({ beaconUserData }) => {
  const classes = useStyles();
  const disability = "Diabetes";

  return (
    <div className={classes.root}>
      <Paper className={classes.paper}>
        <Grid container wrap="nowrap" spacing={2} >
          <Grid item xs={12} sm container>
            <Grid>
              <UseAnimations animationKey="alertOctagon" size={56} style={{ padding: 5, display: 'flex', alignItems: 'center', justifyContent: 'center', }} />
            </Grid>
            <Grid item xs container direction="column" justify="flex-start" spacing={2}>
              <Grid item xs>
                <Typography gutterBottom variant="subtitle1">
                  First and last name
                </Typography>
                <Typography variant="body2" color="textSecondary">
                  <li>In case of fatigue, check blood sugar</li>
                  <li>Provide customer with information on bread units</li>
                  <li>Check well-being every 2h, hold sugary food ready</li>
                </Typography>
              </Grid>

            </Grid>
            <Grid item>
              <Typography fontStyle="italic" variant="subtitle1">Disability</Typography>
            </Grid>
          </Grid>
        </Grid>
      </Paper>
    </div>
  );
}


  /*
const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
  },
  paper: {
    height: 140,
    width: 100,
  },
  control: {
    padding: theme.spacing(2),
  },
}));

  return (
    <Grid container>
      <Grid item xs={10}>
        <Typography>{disability}</Typography>
        <Grid container justify="center" spacing={spacing}>
          {[0, 1, 2].map(value => (
            <Grid key={value} item>
              <Paper className={classes.paper} />
            </Grid>
          ))}
        </Grid>
      </Grid>
      <Grid item xs={10}>
        <Typography>Symptoms</Typography>
      </Grid>
      <Grid item xs={10}>
        <Typography>Action Steps</Typography>
      </Grid>
    </Grid>
  );
}


*/

export default AttentionCard;