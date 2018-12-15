export default {
  endpoint: '/api/v1/authenticate',

  async login (loginCredentials) {
    const url = this.endpoint;
    return fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(loginCredentials)
    }).then(response => {
      return response.json().then(responseData => {
        if (response.ok) {
          return Promise.resolve(responseData);
        } else {
          return Promise.reject(responseData);
        }
      });
    });
  }
};
