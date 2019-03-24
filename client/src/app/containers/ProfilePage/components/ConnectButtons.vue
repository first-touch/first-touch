<template>
  <div class="row mt-3 mx-auto contact-box-wrapper">
    <div class="col-4 col-md-12 mt-md-3">
      <router-link :to="'/messages/'+userId" class="btn btn-primary" tag="button">Message</router-link>
    </div>
    <div class="col-4 col-md-12 mt-md-3">
      <button type="button" class="btn btn-primary">Connect</button>
    </div>
    <div class="col-4 col-md-12 mt-md-3">
      <button type="button" class="btn btn-primary" v-clipboard="() => urlToProfile" v-clipboard:success="clipboardSuccessHandler" v-clipboard:error="clipboardErrorHandler">Share</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ConnectButtons',
  props: ['userId'],
  data() {
    return {
      urlToProfile: "google.com"
    }
  },
  methods: {
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
