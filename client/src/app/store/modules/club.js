import NotesService from 'app/services/NotesService';

export default {
  namespaced: true,
  state: {},
  mutations: {},
  actions: {},
  getters: {},
  modules: {
    notes: {
      namespaced: true,
      state: {
        value: [],
        loading: false
      },
      actions: {
        index ({ commit }) {
          commit('loading');
          NotesService.index().then(res => {
            commit('setNotes', res.notes);
          }).catch(err => {
            console.log(err);
            commit('setNotes', []);
          }).finally(() => {
            commit('loaded');
          });
        }
      },
      mutations: {
        'loading' (state) { state.loading = true; },
        'loaded' (state) { state.loading = false; },
        'setNotes' (state, notes) { state.value = notes; }
      },
      getters: { }
    }
  }
};
