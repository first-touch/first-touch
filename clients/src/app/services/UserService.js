import store from 'app/store';

export default {
  endpoint: '/api/v1/users',
  update (attributes) {
    const token = store.state.token.value;

    return fetch(this.endpoint, {
      method: 'PUT',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(attributes)
    });
  }
};
