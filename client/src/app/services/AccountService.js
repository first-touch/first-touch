export default {
  endpoint: '/api/v1/users/confirmation',
  confirm (confirmationTokenData) {
    return fetch(this.endpoint, {
      method: 'GET',
      body: JSON.stringify(confirmationTokenData)
    });
  }
};
