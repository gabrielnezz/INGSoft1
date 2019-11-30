class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {
      router,
      title,
      classes,
    } = this.props

    const current_path = router.current()
    let onclick = () => {}
    let icon = ""

    if (current_path === "/") {
      icon = "home"
      onclick = () => {}
    } else if (current_path === "/list") {
      icon = "home"
      onclick = () => router.navigate("/", {
        substrings: [],
        selectedSubstring: "",
      })
    } else if (current_path === "/details") {
      icon = "keyboard_arrow_left"
      onclick = () => router.navigate("/list", {
        selectedSubstring: "",
      })
    } else {
      console.error("Not a valid current path!")
    }

    return (
      <div className={classes.rootToolBar}>
        <AppBar position="static">
          <Toolbar>
            <IconButton
              edge="start"
              className={classes.menuButton}
              color="inherit"
              onClick={onclick}
            >
              <Icon>{icon}</Icon>
            </IconButton>
            <Typography variant="h6" className={classes.title}>
              {title}
            </Typography>
          </Toolbar>
        </AppBar>
      </div>
    )
  }

}

// Add style
const MyToolBar = withStyles(styles, {
  withTheme: true
})(MyToolBarComponent)
