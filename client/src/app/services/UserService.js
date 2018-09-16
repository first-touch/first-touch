import store from 'app/store';

export default {
  endpoint: '/api/v1/users',
  update (attributes, resetToken) {
    const token = resetToken || store.state.token.value;

    return fetch(this.endpoint, {
      method: 'PUT',
      headers: {
        Authorization: token
      },
      body: JSON.stringify(attributes)
    });
  }
};
