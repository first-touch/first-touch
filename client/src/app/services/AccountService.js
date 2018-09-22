import $ from 'jquery';

export default {
  endpoint: '/api/v1/users',

  confirm (confirmationTokenData) {
    const urlAction = 'confirmation';
    const url = `${this.endpoint}/${urlAction}?${$.param(confirmationTokenData)}`;
    return fetch(url).then(response => {
      if (response.ok) {
        return Promise.resolve('Activated');
      } else {
        return Promise.reject(response);
      }
    });
  },

  requestPasswordReset (email) {
    const urlAction = 'reset_password';
    const url = `${this.endpoint}/${urlAction}`;
    const data = { 'email': email };
    return fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }).then(response => {
      return response.json();
    });
  },

  updatePassword (passwordData, resetToken) {
    const urlAction = 'update_password';
    const url = `${this.endpoint}/${urlAction}`;
    return fetch(url, {
      method: 'PUT',
      headers: {
        ResetToken: resetToken,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(passwordData)
    }).then(response => {
      return response.json().then(responseData => {
        if (response.ok) {
          return Promise.resolve(responseData);
        } else {
          return Promise.reject(responseData);
        }
      });
    });
  }
};
