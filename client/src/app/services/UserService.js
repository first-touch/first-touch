import $ from 'jquery';
import store from 'app/store';

export default {
  endpoint: '/api/v1/users',

  getUser () {
    const token = store.state.token.value;
    return fetch('/api/v1/user', {
      headers: {
        Authorization: token
      }
    }).then(res => {
      if (res.ok) {
        return res.json();
      } else {
        Promise.reject(res);
      }
    });
  },

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
  },

  search (params) {
    const endpoint = `api/v1/search${$.param(params)}`;
    const token = store.state.token.value;

    return fetch(endpoint, {
      method: 'GET',
      headers: {
        Authorization: token
      }
    }).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  },

  updateProfilePicture (formData) {
    const token = store.state.token.value;
    const user = store.state.user.value;
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
