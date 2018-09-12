import store from 'app/store';

export default {
  endpoint: '/api/v1/users/posts',
  index () {
    return fetch(this.endpoint, {
      method: 'GET',
      headers: {
        Authorization: store.state.token.value
      }
    });
  },

  create (postData) {
    return fetch(this.endpoint, {
      method: 'POST',
      headers: {
        Authorization: store.state.token.value,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(postData)
    });
  }
};
