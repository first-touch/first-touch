import * as types from '../../constants/ActionTypes';

export const getSearchResults = (store, { searchTerm, role = '', team = '' }) => {
  store.commit(types.SEARCH_RESULT_LOADING);
  return fetch(`/api/v1/users/search?q=${searchTerm}&role=${role}&team=${team}`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      return res.json().then(searchResults => {
        store.commit(types.SEARCH_RESULT_SUCCESS, searchResults.users);
        return searchResults.users;
      });
    } else {
      res.json().then(console.log);
    }
  });
};

export const getSearchResultsTeams = (store, { searchTerm, league = '' }) => {
  store.commit(types.SEARCH_RESULT_LOADING);
  return fetch(`/api/v1/teams?q=${searchTerm}&league=${league}`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      return res.json().then(searchResults => {
        store.commit(types.SEARCH_RESULT_SUCCESS, searchResults.teams);
        return searchResults.teams;
      });
    } else {
      res.json().then(console.log);
    }
  });
};

export const getSearchResultsCompetition = (store, { searchTerm }) => {
  store.commit(types.SEARCH_RESULT_LOADING);
  return fetch(`/api/v1/competitions?q=${searchTerm}`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      return res.json().then(searchResults => {
        store.commit(types.SEARCH_RESULT_SUCCESS, searchResults.competitions);
        return searchResults.competitions;
      });
    } else {
      return [];
    }
  });
};
