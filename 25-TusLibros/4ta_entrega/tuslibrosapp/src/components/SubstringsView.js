function SubstringsView(props) {
  const { router, substrings } = props
  const classes = useStyles();

  return (
    <div>
      <Typography component="h1" gutterBottom>
        Encontramos los siguientes substrings:
          </Typography>
      <List component="nav" className={classes.rootList} aria-label="substrings">
        {
          substrings.map((substring, ix) => {
            return (
              <ListItem
                button
                key={ix}
                onClick={() => router.navigate('/details', { selectedSubstring: substring })}>
                <ListItemText primary={substring} />
              </ListItem>
            )
          })
        }
      </List>
    </div>
  )
}

