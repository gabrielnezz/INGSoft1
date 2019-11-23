function StringInputView(props) {
  const { router } = props
  const classes = useStyles();
  const [values, setValues] = React.useState({
    text: '',
  });
  const handleChange = prop => event => {
    setValues({ ...values, [prop]: event.target.value });
  };
  const handleSend = text => {
    getLocalAsJson(`substrings?sentence=${text}`)
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

  return (
    <div>
      <Typography component="h1" gutterBottom>
        Ingrese un texto donde buscar subcadenas
          </Typography>
      <FormControl fullWidth className={classes.textField} variant="outlined">
        <InputLabel htmlFor="outlined-adornment-amount">String</InputLabel>
        <OutlinedInput
          id="outlined-adornment-amount"
          value={values.text}
          onChange={handleChange('text')}
          startAdornment={<InputAdornment position="start">></InputAdornment>}
          labelWidth={60}
          multiline
          rows="7"
        />
      </FormControl>

      <Button
        color="inherit"
        onClick={() => handleSend(values.text)}>
        Enviar
          </Button>
    </div>
  )
}
