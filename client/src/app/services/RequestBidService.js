import store from 'app/store';

export default {
  endpoint: '/api/v1/request_bids',

  create (bid) {
    const token = store.state.token.value;
    return fetch(this.endpoint, {
      method: 'POST',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(bid)
    }).then(res => {
      if (res.ok) {
        return res.json();
      } else {
        return Promise.reject(res);
      }
    });
  }
};
