import store from 'app/store';

export default {
  endpoint: '/api/v1/request_bids',

  create (bid) {
    const token = store.state.token.value;
    const userRole = store.state.user.value.role_name;
    // TODO: Use authedRequest instead
    return fetch(`/api/v1/${userRole}/request_bids`, {
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
