import store from 'app/store';

export default {
  endpoint: '/users/confirmation',
  confirm(confirmationTokenData) {
    return fetch(this.endpoint, {
      method: 'GET',
      body: JSON.stringify(confirmationTokenData)
    });
  }
};
