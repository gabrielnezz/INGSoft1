// Fetch Hook
const useFetchDetails = (substring) => {
  const [details, setDetails] = React.useState([])
  const [loading, setLoading] = React.useState(false)
  const [error, setError] = React.useState(null)

  React.useEffect(() => {
    setLoading(true)
    setError(null)

    let details = {}

    getLocalAsJson(`firstletter?word=${substring}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["firstLetter"] = json

        setLoading(false)
        if (details) {
          setDetails(details)
        } else {
          setDetails([])
        }
      })
      .then(function () {
        setLoading(true)
        setError(null)

        return getLocalAsJson(`touppercase?word=${substring}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["uppercase"] = json

        setLoading(false)
        if (details) {
          setDetails(details)
        } else {
          setDetails([])
        }
      })
      .then(function () {
        setLoading(true)
        setError(null)

        return getLocalAsJson(`vowels?word=${substring}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["vowels"] = json

        setLoading(false)
        if (details) {
          setDetails(details)
        } else {
          setDetails([])
        }
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [substring])

  return { details, loading, error }
}

// Component
function SubstringDetailsView(props) {
  const { router, selectedSubstring } = props
  const classes = useStyles();

  const { details, loading, error } = useFetchDetails(selectedSubstring)

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

