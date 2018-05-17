
import * as ActionTypes from '../../constants/ActionTypes';

export const getClubsCards = (store) => {
  store.commit(ActionTypes.GET_CLUB_STRIPE_ACCOUNT_LOADING);
  fetch('/api/v1/club/stripe', {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.GET_CLUB_STRIPE_ACCOUNT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.GET_CLUB_STRIPE_ACCOUNT_FAILURE, r));
    }
  });
};

export const createClubsCard = (store, data) => {
  store.commit(ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_LOADING);
  fetch('/api/v1/club/stripe', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_FAILURE, r));
    }
  });
};

export const deleteCard = (store, data) => {
  store.commit(ActionTypes.DELETE_CLUB_STRIPE_CARD_LOADING);
  fetch('/api/v1/club/stripe', {
    method: 'DELETE',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.DELETE_CLUB_STRIPE_CARD_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.DELETE_CLUB_STRIPE_CARD_FAILURE, r));
    }
  });
};

export const updateCards = (store, data) => {
  store.commit(ActionTypes.GET_CLUB_STRIPE_ACCOUNT_LOADING);
  fetch('/api/v1/club/stripe', {
    method: 'PUT',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.GET_CLUB_STRIPE_ACCOUNT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.GET_CLUB_STRIPE_ACCOUNT_FAILURE, r));
    }
  });
};
