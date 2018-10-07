import * as types from 'app/constants/ActionTypes';

export const getSearchResults = (store, { searchTerm, role = '', team = '' }) => {
  store.commit(types.SEARCH_RESULT_LOADING);
  fetch(`/api/v1/search?q=${searchTerm}&role=${role}&team=${team}`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.SEARCH_RESULT_SUCCESS, r.users));
    } else {
      res.json().then(console.log);
    }
  });
};

export const getSearchResultsTeams = (store, { searchTerm, league = '' }) => {
  store.commit(types.SEARCH_RESULT_LOADING);
  fetch(`/api/v1/teams?q=${searchTerm}&league=${league}`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.SEARCH_RESULT_SUCCESS, r));
    } else {
      res.json().then(console.log);
    }
  });
};

export const getSearchResultsCompetition = (store, { searchTerm }) => {
  store.commit(types.SEARCH_RESULT_LOADING);
  fetch(`/api/v1/competitions?q=${searchTerm}`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.SEARCH_RESULT_SUCCESS, r));
    } else {
      res.json().then(console.log);
    }
  });
};

export const flushSearchResults = (store) => {
  store.commit(types.SEARCH_RESULT_FLUSH);
};
