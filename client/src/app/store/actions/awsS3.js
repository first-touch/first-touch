export const getSignedUrl = (store, order) => {
  return fetch('/api/v1/direct_upload/signed_url', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      return res.json();
    }
    return null;
  });
};
