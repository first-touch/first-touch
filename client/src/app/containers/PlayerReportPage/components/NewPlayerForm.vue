<template>
  <form @submit.prevent="handleSubmit">
    <playerform :personal_profile="personal_profile" />
    <fieldset class="form-group col-md-12">
      <button type="submit" class="bar-button center">Save</button>
    </fieldset>
  </form>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .form-group {
    label {
      color: $main-text-color;
    }
    .bar-button {
      color: $main-text-color;
      border: 1px solid $main-text-color;
    }
  }
</style>

<script>
  import PlayerForm from './PlayerForm.vue';

  export default {
    name: 'EditProfileForm',
    props: [
      'createUserInfo',
    ],
    components: {
      playerform: PlayerForm,
    },
    data() {
      return {
        personal_profile: {
          pro_status: '',
          total_caps: null,
          languages: [],
          playing_position: [],
          first_name: this.firstName || '',
          middle_name: this.middleName || '',
          last_name: this.lastName || '',
          bMonth: this.month || '',
          bDay: this.day || '',
          bYear: this.year || '',
          residence_country_code: this.residence_country_code || '',
          place_of_birth: this.placeOfBirth || '',
          weight: this.pWeight || '',
          height: this.pHeight || '',
          preferred_foot: this.preferredFoot || '',
        }
      };
    },
    methods: {
      handleSubmit() {
        this.personal_profile.birthday = new Date(Date.UTC(this.personal_profile.bYear, this.personal_profile.bMonth, this.personal_profile.bDay));
        this.createUserInfo(this.personal_profile);
      },
    },
  };
</script>