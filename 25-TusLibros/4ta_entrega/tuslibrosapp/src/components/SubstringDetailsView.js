class SubstringDetailsComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      details: {},
      loading: false,
      error: null,
    }
  }

  componentDidMount() {
    const substring = this.props.selectedSubstring

    this.setState({
      loading: true,
      error: null,
    })

    let details = {}

    getLocalAsJson(`firstletter?word=${substring}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["firstLetter"] = json
        return getLocalAsJson(`touppercase?word=${substring}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["uppercase"] = json
        return getLocalAsJson(`vowels?word=${substring}`)
      })
      .then(function(response) {
        return response.json()
      })
      .then(function (json) {
        details["vowels"] = json
        return details
      })
      .then((details) => {
        this.setState({
          loading: false,
          details: details
        })
      })
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
  }

  render() {
    const {
      // router,
      selectedSubstring,
      classes,
    } = this.props

    const {
      details,
      loading,
      error,
    } = this.state

    if (loading) return <div>Loading...</div>
    if (error) return <div>{error}</div>

    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          Detalles de <b>{selectedSubstring}</b>
        </Typography>

        <TextField
          id="outlined-read-only-input"
          label="Primera letra"
          defaultValue={details["firstLetter"]}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />
        <TextField
          id="outlined-read-only-input"
          label="En mayúsculas"
          defaultValue={details["uppercase"]}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />
        <TextField
          id="outlined-read-only-input"
          label="Vocales"
          defaultValue={details["vowels"]}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />
      </div>
    )
  }
}

// Add style
const SubstringDetailsView = withStyles(styles, {
  withTheme: true
})(SubstringDetailsComponent)
