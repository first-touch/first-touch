import jQuery from 'jquery/dist/jquery';

export default {
  endpoint: '/api/v1/users/confirmation',
  confirm (confirmationTokenData) {
    const url = `${this.endpoint}/${jQuery.param(confirmationTokenData)}`;
    return fetch(url);
  }
};
