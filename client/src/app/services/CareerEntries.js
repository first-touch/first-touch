import store from 'app/store';

export default {
  endpoint: '/api/v1',
  updateCareerEntries (formData) {
    const token = store.state.token.value;
    const user = store.state.user.value;
    return fetch(`${this.endpoint}/career_entries`, {
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
  }
};
