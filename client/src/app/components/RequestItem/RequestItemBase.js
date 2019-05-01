import countrydata from 'country-data';

export default {
  props: [
    'request',
    'update',
    'own',
    'viewSummary',
    'addBid',
    'createReport',
    'viewReport',
    'cancelReport',
    'mode',
    'widgets'
  ],
  data () {
    return {
      firstAction: '',
      listAction: true,
      afterMountedAction: false
    };
  },

  computed: {
    src: function () {
      var src = '';
      switch (this.request.type_request) {
      case 'player':
        src = '/images/landing-page/ft-icons-player.png';
        break;
      case 'team':
        src = '/images/landing-page/ft-icons-club.png';
        break;
      case 'position':
        src = '/images/landing-page/ft-icons-player.png';
        break;
      }
      return src;
    },
    bidStatus () {
      if (this.own) return false;
      if (this.request.bid_status) {
        if (
          this.request.bid_status === 'accepted' ||
          this.request.bid_status === 'joblist'
        ) {
          return 'C';
        }
        if (this.request.bid_status === 'completed') return 'R';
        if (this.request.bid_status === 'pending') return 'U';
      }
      return 'N';
    },
    position () {
      if (this.request.type_request === 'position') {
        return true;
      }
      return false;
    },
    haveBid () {
      return this.request.bid_status;
    },
    clubProfile () {
      return this.$router.matcher.match({
        name: 'teamProfilePage'
      }).matched.length > 0;
    },
    isAccepted () {
      if (this.request.bid_status) {
        if (
          this.request.bid_status === 'accepted' ||
          this.request.bid_status === 'joblist'
        ) {
          return true;
        }
        return false;
      }
      return false;
    }
  },
  methods: {
    getLanguage (key) {
      return countrydata.languages[key] ? countrydata.languages[key].name : key;
    },
    getNationality (key) {
      return countrydata.countries[key] ? countrydata.countries[key].name : key;
    },
    canAction (condition, actionName, first) {
      if (condition) {
        if (first) {
          if (this.firstAction !== '' && this.firstAction !== actionName) {
            return false;
          }
          this.firstAction = actionName;
          return true;
        } else if (!first && this.firstAction !== actionName) {
          this.afterMountedAction = true;
          return true;
        }
      }
      return false;
    },

    unpublishItem (id) {
      this.$emit('update-status', id, 'private');
    },

    publishItem (id) {
      this.$emit('update-status', id, 'publish');
    },

    deleteItem (id) {
      this.$emit('update-status', id, 'deleted');
    }
  }
};
