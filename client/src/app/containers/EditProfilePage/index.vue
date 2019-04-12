<template>
  <div>
    <!-- <sidebar /> -->
    <div class="container">
      <div class="ft-page edit-profile">
        <h4 class="spaced-title upper-cased main-color">Edit Profile</h4>
        <div class="profile-item">
          <div class="arrow"></div>

          <div class="form-container">
            <edit-form v-if="loaded"
              :profile="personalProfile"
              :role="role"
              @save="updateUser"

              :avatarUrl="avatarUrl"
              :clubCountry="clubCountry"
              :careerHistory="careerHistory" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.profile-item {
  display: flex;
  border-left: 7px solid $main-header-color;
  margin-top: 20px;

  color: $main-text-color;
  
  .arrow {
    margin-top: 18px;
    border-left-color: $main-header-color;
  }
  .form-container {
    background-color: #fff;
    border-radius: 5px;
    padding: 20px;
    width: 100%;
  }
}

.edit-profile-two {
    margin-top: 15px;
}

</style>

<script>
import NotificationSidebar from 'app/components/NotificationSidebar';
import EditProfileForm from './components/EditProfileForm';
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';

export default {
  name: 'EditProfilePage',
  components: {
    sidebar: NotificationSidebar,
    'edit-form': EditProfileForm,
  },
  computed: {
    ...mapGetters(['user']),
    loaded() {
      return this.user.status === ASYNC_SUCCESS;
    },
    personalProfile() {
      return this.user.status === ASYNC_SUCCESS
        ? this.user.value.personal_profile
        : {
            residence_country_code: null,
            first_name: null,
            birthday: null,
            height: null,
            languages: null,
            last_name: null,
            middle_name: null,
            nationality_country_code: null,
            place_of_birth: null,
            preferred_foot: null,
            weight: null,
          };
    },
    role() {
      return this.user.value.role_name || '';
    },
    careerHistory() {
      if(!this.user) { return [] }
      return this.user.value.career_history|| [];
    },
    clubs() {
      if(!this.user) { return [] }
      return this.careerHistory.club || [];
    },
    clubCountry() {
      return this.clubs.country_code ||'';
    },
    
    avatarUrl() {
      return this.personalProfile.avatar_url;
    }
  },
  methods: {
    ...mapActions(['updateUserInfo']),
    updateUser(info) {
      this.updateUserInfo(info).then((r) => {

        this.flash("Updated successfully", "success", {
          timeout: 3000,
          important: true
        });
      })
    }
  },
};
</script>
