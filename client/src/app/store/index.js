import Vue from 'vue';
import Vuex from 'vuex';
import mutations, { initialState as state } from './mutations';
import * as actions from './actions';

Vue.use(Vuex);

const getters = Object.keys(state).reduce((v, k) => {
  v[k] = state => state[k];
  return v;
}, {
  userClubId: (state) => {
    if (state.clubs.length > 0) {
      return state.clubs[0].id;
    } else {
      return undefined;
    }
  }
});

export default new Vuex.Store({
  state,
  mutations,
  actions,
  getters
});
