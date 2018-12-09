// NOTE: needed for $.param
import $ from 'jquery';
import store from '../store';

export default {
  endpoint: '/api/v1/clubs',

  countriesForClubs () {
    const url = `${this.endpoint}/countries`;
    return fetch(url).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  },

  searchClub (params) {
    const url = `${this.endpoint}/search?${$.param(params)}`;
    return fetch(url).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  },

  create (data) {
    return fetch(this.endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });
  },

  update (data) {
    // how do i retrieve the authorization token from here?
    fetch(`${this.endpoint}/${data.id}`, {
      method: 'PUT',
      headers: {
        Authorization: store.state.token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });
  },

  show (clubId) {
    const url = `${this.endpoint}/${clubId}`;
    return fetch(url).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  }
};
