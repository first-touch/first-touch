import store from 'app/store';

export default {
  endpoint: '/api/v1/users/:id/media',

  upload (mediaParams) {
    const url = this.endpoint.replace(/\:id/, store.state.user.value.id);
    const token = store.state.token.value;
    return fetch(url, {
      method: 'POST',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(mediaParams)
    }).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  },

  delete (mediumId) {
    const url = this.endpoint.replace(/\:id/, store.state.user.value.id);
    const token = store.state.token.value;
    return fetch(`${url}/${mediumId}`, {
      method: 'DELETE',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      }
    }).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  }
};
