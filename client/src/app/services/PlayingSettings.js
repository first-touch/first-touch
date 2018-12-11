
export default {
  endpoint: '/api/v1/settings',
  playingPositions () {
    const url = `${this.endpoint}/playing_positions`;
    return fetch(url).then(response => {
      if (response.ok) {
        return response.json();
      } else {
        return Promise.reject(response);
      }
    });
  }
};
