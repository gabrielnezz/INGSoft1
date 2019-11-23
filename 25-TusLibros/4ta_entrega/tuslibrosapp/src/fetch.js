const getLocalAsJson = (path) => {

  // var port = 8080
  var port = 8082

  return fetch(`http://localhost:${port}/${path}`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
}
