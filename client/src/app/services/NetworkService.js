import $ from 'jquery';
import store from 'app/store';

export default {
  endpoint: 'api/v1/network',

  index (role) {
    const params = { role: role };
    const endpoint = `${this.endpoint}?${$.param(params)}`;
    const token = store.state.token.value;

    return fetch(endpoint, {
      method: 'GET',
      headers: {
        Authorization: token,
        'Content-Type': 'application/json'
      }
    }).then(res => {
      if (res.ok) {
        return res.json();
      } else {
        return Promise.reject(res);
      }
    });
  }
};
