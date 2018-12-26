<template>
  <div>
    <div class="row">
      <div class="col-lg-5">
        <h4 class="name">Write a new message</h4>
      </div>
      <div class="col-lg-7">
        <div class="form-inline float-right">
          <div class="form-group mx-1">
            <button class="form-control a-bar-button">Send</button>
          </div>
          <div class="form-group mx-1">
            <button class="form-control a-bar-button reverse">Close</button>
          </div>
        </div>
      </div>
    </div>
    <div class="form">
      <fieldset class="form-group col-md-12">
        <input type="users" v-model="user_ids" class="form-control" placeholder="Type a name" />
      </fieldset>
      <fieldset class="form-group col-md-12">
        <input type="subject" v-model="subject" class="form-control" placeholder="Give this conversation a name(optional)" />
      </fieldset>
      <fieldset class="form-group col-md-12">
        <input type="body" v-model="body" class="form-control" placeholder="Write your message..." />
      </fieldset>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/variables';

  .row {
    margin-bottom: 30px;
  }

  h4 {
    color: $main-text-color;
  }

</style>

<script>
export default {
  name: 'NewMessagePopup',
  data() {
    return {
      user_ids: [],
      subject: '',
      body: '',
    }
  }
};
</script>
