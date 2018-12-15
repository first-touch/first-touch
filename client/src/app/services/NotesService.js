// NOTE: needed for $.param
import $ from 'jquery';
// NOTE: I'm not sure the api service should know about
// the store, but for the time being stays here
import store from 'app/store';

export default {
  endpoint: '/api/v1/notes',

  index (params = {}) {
    const url = `${this.endpoint}?${$.param(params)}`;
    return new Promise((resolve, reject) => {
      return fetch(url, {
        method: 'GET',
        headers: {
          Authorization: store.state.token.value
        }
      }).then(response => {
        if (response.ok) {
          return resolve(response.json());
        } else {
          return reject(response);
        }
      });
    });
  },

  create (noteData) {
    return fetch(this.endpoint, {
      method: 'POST',
      headers: {
        Authorization: store.state.token.value,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(noteData)
    });
  }
};
