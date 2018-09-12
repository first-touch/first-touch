import $ from 'jquery';

export default {
  endpoint: '/api/v1/users/confirmation',
  confirm (confirmationTokenData) {
    const url = `${this.endpoint}/?${$.param(confirmationTokenData)}`;
    return fetch(url).then(response => {
      if (response.ok) {
        return Promise.resolve('Activated');
      } else {
        return Promise.reject(response);
      }
    });
  }
};
