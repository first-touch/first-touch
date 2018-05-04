import * as ActionTypes from '../../constants/ActionTypes';
import {
  StripePublicKey
} from 'app/constants/StripeConstant';
export const saveStripe = (store, data) => {
  store.commit(ActionTypes.SAVE_STRIPE_ACCOUNT_LOADING);
  fetch('/api/v1/stripe', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.SAVE_STRIPE_ACCOUNT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.SAVE_STRIPE_ACCOUNT_FAILURE, r));
    }
  });
};

export const newStripeToken = (store, { data, tokenType }) => {
  store.commit(ActionTypes.STRIPE_CREATE_ACCOUNT_LOADING);
  var stripe = window.Stripe(StripePublicKey);
  stripe.createToken(tokenType, data).then(function (result) {
    console.log(result);
    if (result.token) {
      store.commit(ActionTypes.STRIPE_CREATE_ACCOUNT_SUCCESS, result);
    } else {
      store.commit(ActionTypes.STRIPE_CREATE_ACCOUNT_FAILURE, result);
    }
  });
};

export const getStripe = (store) => {
  store.commit(ActionTypes.GET_STRIPE_ACCOUNT_LOADING);
  fetch('/api/v1/stripe', {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.GET_STRIPE_ACCOUNT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.GET_STRIPE_ACCOUNT_FAILURE, r));
    }
  });
};

export const getStripeRequiredInfo = (store, country) => {
  store.commit(ActionTypes.STRIPE_REQUIRED_FIELDS_LOADING);
  fetch(`/api/v1/stripe/required?country=${country}`, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.STRIPE_REQUIRED_FIELDS_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.STRIPE_REQUIRED_FIELDS_FAILURE, r));
    }
  });
};
