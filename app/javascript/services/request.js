const headers = new Headers({});

const request = async (method, path, body = null) => {
  headers.set("Content-Type", "application/json");

  const baseUrl = "";
  let fetchOptions = { method, headers };
  if (body !== null) {
    fetchOptions = { ...fetchOptions, body: JSON.stringify(body) };
  }
  const url = `${baseUrl}${path}`;
  const response = await fetch(url, fetchOptions);

  const validStatuses = [200, 201, 302];
  const invalidStatuses = [401, 404, 422, 400, 500];

  if (validStatuses.includes(response.status)) {
    return response;
  } else if (invalidStatuses.includes(response.status)) {
    // throw new Error(
    console.log(
      `Error fetching ${url}: ${response.status} (${response.statusCode}) ${response.body}`
    );
  }

  return response;
};

export default request;
