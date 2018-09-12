export default {
  endpoint: '/api/v1/clubs',
  firstTouchCountries () {
    const url = `${this.endpoint}/countries`;
    return fetch(url).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  }
};
