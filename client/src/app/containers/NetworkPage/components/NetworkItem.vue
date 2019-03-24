<template>
  <div class="network-item row">
    <div class="col-2 avatar-wrapper">
      <div class="avatar img-responsive img-circle" v-bind:style="{ 'background-image': 'url('+avatarUrl+')' }"></div>
    </div>
    <div class="col-6 mt-auto mb-auto">
      <div class="row">
        <div class="col-12">
          <router-link :to="profileUrl" class="a-link dark large-sub-title"> {{ displayName }}</router-link>
        </div>
        <div class="col-12">
          <h5 class="role">{{ role }}</h5>
        </div>
      </div>
    </div>
    <div class="col-4 mt-auto mb-auto">
      <router-link :to="'/messages/'+userId" class="btn btn-primary" tag="button">Message</router-link>
    </div>
  </div>
</template>


<script>
export default {
  name: 'NetworkItem',
  props: ['info', 'unfollow'],
  computed: {
    displayName() {
      return this.info.display_name;
    },
    avatarUrl() {
      return this.info.avatar_url;
    },
    profileUrl() {
      return `users/${this.userId}/profile`;
    },
    userId() {
      return this.info.id;
    },
    role() {
      if(!this.info) { return "Unknown"; }
      return _.capitalize(this.info.role_name);
    }
  }
};
</script>
