import _ from 'lodash';
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
        loading: false,
        publishing: false
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
        },
        create ({ commit }, noteData) {
          commit('publishing');
          NotesService.create(noteData).then(res => {
            commit('addNote', res);
          }).catch(err => {
            console.log(err);
          }).finally(() => {
            commit('published');
          });
        }
      },
      mutations: {
        'loading' (state) { state.loading = true; },
        'loaded' (state) { state.loading = false; },
        'publishing' (state) { state.publishing = true; },
        'published' (state) { state.publishing = false; },
        'setNotes' (state, notes) { state.value = notes; },
        'addNote' (state, note) { state.value.push(note); }
      },
      getters: {
        allNotes (state) {
          return _.orderBy(state.value, 'updated_at', 'desc');
        }
      }
    }
  }
};
