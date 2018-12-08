import Vue from 'vue';
import Vuex from 'vuex';
// import mutations, { initialState as state } from './mutations';
// import * as actions from './actions';
import auth from './modules/auth'

Vue.use(Vuex);

// const getters = Object.keys(state).reduce((v, k) => {
//   v[k] = state => state[k];
//   return v;
// }, {});

export default new Vuex.Store({
  state: {},
  getters: {},
  mutations: {},
  actions: {},

  modules: {
    auth
  }
});
