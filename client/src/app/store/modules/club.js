import NotesService from 'app/services/NotesService';

//   return new Promise((resolve, reject) => {
//     store.commit('CLUB_LOADING');
//     return NotesService.show(clubId).then(res => {
//       store.commit('CLUB_LOAD_SUCCESS', res);
//       resolve(res);
//     }).catch(err => {
//       console.log(err);
//       store.commit('CLUB_LOAD_ERROR', err);
//       reject(err);
//     });
//   });
// };

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
        index ({ dispatch, commit }) {
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
      getters: {}
    }
  }
};
