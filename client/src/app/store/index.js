import Vue from 'vue';
import Vuex from 'vuex';
import mutations, { initialState as state } from './mutations';
import * as actions from './actions';

Vue.use(Vuex);

export default new Vuex.Store({
  state,
  mutations,
  actions,
  getters: {
    todos: state => state.todos,
    token: state => state.token,
    feed: state => state.feed,
    user: state => state.user,
    network: state => state.network,
    inbox: state => state.inbox,
    messages: state => state.messages
  }
});
