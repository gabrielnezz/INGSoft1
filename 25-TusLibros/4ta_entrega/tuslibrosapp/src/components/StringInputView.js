class StringInputComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      sentence: "",
    }
  }

  handleChange(event) {
    this.setState({
      sentence: event.target.value
    })
  };

  handleSend() {
    const {
      router,
    } = this.props

    const {
      sentence,
    } = this.state

    getLocalAsJson(`substrings?sentence=${sentence}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        router.navigate("/list", { substrings: json })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  render() {
    const {
      sentence,
    } = this.state

    const {
      classes,
    } = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Ingrese un texto donde buscar subcadenas
          </Typography>
        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">String</InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={sentence}
            onChange={(ev)=>this.handleChange(ev)}
            startAdornment={<InputAdornment position="start">></InputAdornment>}
            labelWidth={60}
            multiline
            rows="7"
          />
        </FormControl>

        <Button
          color="inherit"
          onClick={(ev)=>this.handleSend(ev)}>
          Enviar
      </Button>
      </div>
    )
  }
}

// Add style
const StringInputView = withStyles(styles, {
  withTheme: true
})(StringInputComponent)
