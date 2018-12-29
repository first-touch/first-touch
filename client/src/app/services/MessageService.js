import store from 'app/store';

export default {
  endpoint: '/api/v1/messages',

  create (data) {
    return fetch(this.endpoint, {
      method: 'POST',
      headers: {
        Authorization: store.state.token.value,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });
  }
};
