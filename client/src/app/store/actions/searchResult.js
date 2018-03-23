import * as types from '../../constants/ActionTypes';

export const getSearchResults = (store, { searchTerm, role = '' }) => {
  console.log(role);
  store.commit(types.SEARCH_RESULT_LOADING);
  if (searchTerm === '') return store.commit(types.SEARCH_RESULT_SUCCESS, []);
  fetch(`/api/v1/search?q=${searchTerm}&role=${role}`, {
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
