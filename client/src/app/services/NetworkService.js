import store from 'app/store';

export default {
  endpoint: 'api/v1/network',

  index () {
    const token = store.state.token.value;
    return fetch(this.endpoint, {
      method: 'GET',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      }
    });
  }
  // endpoint: 'api/v1/network',

  // index (role) {
  //   const token = store.state.token.value;

  //   return fetch(this.endpoint, {
  //     method: 'GET',
  //     headers: {
  //       Authorization: token
  //       'Content-Type': 'application/json'
  //     },
  //     body: JSON.stringify()
  //   }).then(res => {
  //     if (res.ok) {
  //       return res.json();
  //     } else {
  //       return Promise.reject(res);
  //     }
  //   });
  // }
};

// if (res.status === 200) {
//   res.json().then(r => {
//     store.commit(types.NETWORK_SUCCESS, r.network);
//   });
// } else if (res.status === 401) {
//   store.commit(types.TOKEN_CLEAR);
// } else {
//   res.json().then(console.log);
// }
// });
