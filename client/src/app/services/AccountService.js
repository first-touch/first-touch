import $ from 'jquery';

export default {
  endpoint: '/api/v1/users/confirmation',
  confirm (confirmationTokenData) {
    const url = `${this.endpoint}/?${$.param(confirmationTokenData)}`;
    return fetch(url);
  }
};
