import store from 'app/store';

export default {
  endpoint: '/api/v1/users',

  update (attributes) {
    const token = store.state.token;

    return fetch(this.endpoint, {
      method: 'PUT',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(attributes)
    });
  },

  updateProfilePicture (formData) {
    const token = store.state.token;
    const user = store.state.user;
    return fetch(`${this.endpoint}/${user.id}/avatar`, {
      method: 'POST',
      headers: {
        Authorization: token
      },
      body: formData
    }).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  },

  register (data) {
    return fetch(`${this.endpoint}/register`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });
  }
};
