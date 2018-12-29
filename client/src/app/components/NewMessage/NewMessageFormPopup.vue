<template>
  <div>
    <div class="row">
      <div class="col-lg-5">
        <h4 class="name">Write a new message</h4>
      </div>
      <div class="col-lg-7">
        <div class="form-inline float-right">
          <div class="form-group mx-1">
            <button class="form-control a-bar-button" v-on:click="send">Send</button>
          </div>
          <div class="form-group mx-1">
            <button class="form-control a-bar-button reverse" v-on:click="closeModal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <div class="form">
      <fieldset class="form-group col-md-12">
        <vselect multiple :options="users_list" v-model="chosen_users" label="display_name" placeholder="Type a name"></vselect>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <input type="subject" v-model="subject" class="form-control" placeholder="Give this conversation a name(optional)" />
      </fieldset>
      <fieldset class="form-group col-md-12">
        <input type="body" v-model="body" class="form-control" placeholder="Write your message..." />
      </fieldset>
    </div>
    <div v-if="error" class="alert alert-danger">
      <em>{{ error }}</em>
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
import vSelect from 'vue-select';
import UserService from 'app/services/UserService'
import MessageService from 'app/services/MessageService'

export default {
  name: 'NewMessagePopup',
  components: {
    vselect: vSelect
  },
  data() {
    return {
      users_list: [],
      chosen_users: [],
      subject: '',
      body: '',
      error: null
    }
  },
  methods: {
    fetchUsers() {
      UserService.search({}).then(response => {
        this.$set(this, 'users_list', response.users)
      });
    },
    send() {
      if (!this.body) {
        return this.$set(this, 'error', "You need to write a message");
      } else if (this.chosen_users.length === 0) {
        return this.$set(this, 'error', 'You need to select at least one user to send the message to');
      }

      const chosen_user_ids = this.chosen_users.map(user => user.id)

      $.each(chosen_user_ids, function(index, user_id) {
        const messageData = {
          recipient_id: user_id,
          message_body: this.body,
          subject: this.subject
        }
        MessageService.create(messageData).then(res => {
          if (res.status === 201) {
            this.closeModal()
          } else {
            return this.$set(this, 'error', "There was an error sending the message");
          }
        })
      }.bind(this));
    },
    closeModal() {
      this.$emit('closeModal', true)
    }
  },
  mounted() {
    this.fetchUsers();
  }
};
</script>
