
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

export const createClubsCard = (store) => {
  store.commit(ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_LOADING);
  fetch('/api/v1/club/stripe', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_FAILURE, r));
    }
  });
};
