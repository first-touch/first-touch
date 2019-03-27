<template>
  <div class="row mt-3 mx-auto contact-box-wrapper">
    <div class="col-4 col-md-12 mt-md-3">
      <router-link :to="'/messages/'+userId" class="btn btn-primary" tag="button">Message</router-link>
    </div>
    <div class="col-4 col-md-12 mt-md-3">
      <button type="button" class="btn btn-primary" @click="connectAction">{{connectButton}}</button>
    </div>
    <div class="col-4 col-md-12 mt-md-3">
      <button type="button" class="btn btn-primary" v-clipboard="() => urlToProfile" v-clipboard:success="clipboardSuccessHandler" v-clipboard:error="clipboardErrorHandler">Share</button>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  name: 'ConnectButtons',
  props: ['userId', 'connectionStatus'],
  data() {
    return {
      urlToProfile: 'google.com'
    }
  },
  computed: {
    connectButton (){
      if (this.connectionStatus == 'none') {
        return 'Connect';
      } else if (this.connectionStatus == 'requested') {
        return 'Invitation sent';
      } else if (this.connectionStatus == 'pending') {
        return 'Accept connection'
      } else if (this.connectionStatus == 'accepted') {
        return 'Disconnect';
      }
    }
  },
  methods: {
    ...mapActions(['connect']),
    connectAction() {
      if (this.connectionStatus == 'none') {
        this.connect({ id: this.userId });
        // request connection
      } else if (this.connectionStatus == 'requested') {
        // do nothing
      } else if (this.connectionStatus == 'pending') {
        // accept connection
      }
    },

    clipboardSuccessHandler ({ value, event }) {
      this.flash('Profile link copied', 'success', {
        timeout: 2000,
        important: true
      });
    },

    clipboardErrorHandler ({ value, event }) {
      console.log('error', value)
    }
  },
}
</script>
