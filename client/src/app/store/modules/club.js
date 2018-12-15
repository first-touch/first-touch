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
        value: {},
        loading: false
      },
      actions: {
        index () {
          console.log(arguments);
        }
      },
      mutations: {},
      getters: {}
    }
  }
};
