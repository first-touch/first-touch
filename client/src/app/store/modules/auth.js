state = {
  token: null,
  club_token: null
},
getters = {
  TOKEN: state => {
    return state.token;
  },
  CLUB_TOKEN: state => {
    return state.club_token
  }
},
mutations = {
  SET_TOKEN: (state, payload) => {
    state.token = payload
  },
  SET_CLUB_TOKEN: (state, payload) => {
    state.club_token = payload
  },
},
actions = {
  GET_TODO: async (context, payload) => {
    let {
      data
    } = await Axios.get('http://yourwebsite.com/api/todo')
    context.commit('SET_TODO', data)
  },
  SAVE_TODO: async (context, payload) => {
    let {
      data
    } = await Axios.post('http://yourwebsite.com/api/todo')
    context.commit('ADD_TODO', payload)
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
