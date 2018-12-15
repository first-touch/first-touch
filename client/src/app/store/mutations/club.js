export const clubProfile = {
  value: {},
  loading: false,
  errors: []
};

export default {
  'CLUB_LOADING' (state) {
    state.clubProfile.loading = true;
  },
  'CLUB_LOAD_SUCCESS' (state, payload) {
    state.clubProfile.loading = false;
    state.clubProfile.value = payload;
    state.clubProfile.errors = [];
  },
  'CLUB_LOAD_ERROR' (state, payload) {
    state.clubProfile.loading = false;
    state.clubProfile.value = {};
    state.clubProfile.errors = payload;
  },
  'CLUB_CLEAR' (state) {
    state.clubProfile = {
      value: {},
      loading: false,
      errors: []
    };
  }
};
