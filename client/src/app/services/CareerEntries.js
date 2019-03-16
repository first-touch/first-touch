import store from 'app/store';

export default {
  endpoint: '/api/v1/career_entries',
  updateCareerEntries (data) {
    const token = store.state.token.value;
    return fetch(`${this.endpoint}`, {
      method: 'POST',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  },
  returnUserInfo () {
    const token = store.state.token.value;
    return fetch('/api/v1/user', {
      method: 'GET',
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
  },
  deleteCareerEntries (data) {
    const token = store.state.token.value;
    console.log(token);
    return fetch(`${this.endpoint}/` + data, {
      method: 'DELETE',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  }
};
