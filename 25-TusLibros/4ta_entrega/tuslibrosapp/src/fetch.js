const port = 8002.
const getLocalAsJson = (path) => {

  // var port = 8080

  return fetch(`http://localhost:${port}/${path}`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
}

const checkIfCartExists = (cartId, path) => {
	let url = `http://localhost:${port}/${path}`
	let params = {cartId: cartId}
	url.search = new URLSearchParams(params).toString();
	return fetch(url, {
	method: "GET",
	dataType: "JSON",
	headers: {
	  "Access-Control-Request-Headers": "*"
	}
	})
}