import $ from 'jquery';

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
  update (clubId, data) {
    fetch('/api/v1/clubs/' + clubId, {
      method: 'PUT',
      headers: {
        Authorization: this.$store.state.token.value,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data),
    })
  }
};
