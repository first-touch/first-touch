import store from 'app/store';

export default {
  endpoint: '/api/v1',
  updateCareerEntries (formData) {
    const token = store.state.token.value;
    return fetch(`${this.endpoint}/career_entries`, {
      method: 'POST',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      },
      body: formData
    }).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  }
};
