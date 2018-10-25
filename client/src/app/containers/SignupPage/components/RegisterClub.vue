<template>
  <div>
    <navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>
      <div class="col col-lg-5">
        <form class="form" @submit.prevent="handleSubmit">
          <div class="steps-container">
            <p class="steps inactive"> Step 1 - Personal Details </p>
            <p class="steps active"> Step 2 - Register Club </p>
          </div>

          <div class="row">
            <select v-model="club_country_code" class="form-control col-md-4">
              <option disabled value="" selected>Country</option>
              <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
            </select>
            <autocomplete class="col-md-8" input-class="form-control"
              placeholder="Search For Club"
              v-model="item"
              :get-label="getLabel"
              :items="clubs"
              :component-item="template"
              @update-items="updateItems"
              :min-len="0"
              :auto-select-one-item="false"
              :input-attrs="{disabled: countries.length === 0 || club_country_code === ''}"
              />
          </div>
          </fieldset>
          <fieldset class="col-md-12">
            <div v-if="error" class="alert alert-danger">
              <em>{{ error }}</em>
            </div>
          </fieldset>
          <button :disabled="!canBeRegistered()" class="a-bar-button center" type="submit">Register Club</button>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/template/sign-in-page.scss';

.a-bar-button {
  margin-top: 50px;
}

.steps-container {
  margin-right: 5vw;
}
</style>


<style lang="scss">
@import '~stylesheets/molecules/auto-complete.scss';
@import '~stylesheets/molecules/steps.scss';
@import '~stylesheets/variables';

</style>

<script>
import { mapActions } from 'vuex';
import LandingNavbar from 'app/components/LandingNavbar';
import AutoComplete from 'v-autocomplete';
import ItemTemplate from './ItemTemplate';

export default {
  name: 'RegisterClub',
  components: {
    navbar: LandingNavbar,
    autocomplete: AutoComplete
  },
  data() {
    return {
      club_country_code: '',
      countries: [],
      clubs: [],
      template: ItemTemplate,
      item: null,
      error: null
    }
  },
  methods: {
    handleSubmit() {
      if (this.canBeRegistered()) {
        const data = {
          user_id: this.$store.state.userID,
          id: this.item.id
        }
        ClubService.update(this.item.id, data).then(res => {
          if (res.status == 200) {
            alert('Club successfully registered')
            this.$router.push({ path: '/users/sign_in' });
          } else {
            res.json().then(r => this.$set(this, 'error', r.errors.join(", ")));
          }
        })
      }
      else {
        alert(this.error)
      }
    },
    canBeRegistered() {
      return this.item != null && this.error == null
    },
    fetchCountries() {
      fetch('/api/v1/clubs/countries')
        .then(res => res.status === 200 && res.json())
        .then(({ countries }) =>
          this.$set(
            this,
            'countries',
            countries.sort((a, b) => a.country_name > b.country_name),
          ),
        );
    },
    updateItems(text) {
      this.$set(this, 'searchText', text);
      if (!text) return this.$set(this, 'clubs', []);
      fetch(`/api/v1/clubs/search?country=${this.club_country_code}&q=${text}`)
        .then(res => res.status === 200 && res.json())
        .then(({ clubs }) => {
          this.$set(this, 'clubs', clubs.slice(0, 3));
        });
    },
    getLabel(item) {
      return item ? item.name : this.searchText;
    },
    itemSelected(item) {
      this.$set(this, 'item', item);
    },
  },
  watch: {
    item: function(value) {
      fetch('/api/v1/clubs/' + value.id)
        .then(res => res.status === 200 && res.json())
        .then(({has_owner}) => {
          if (has_owner) {
            return this.$set(this, 'error', "The club that you have chosen already has an existing director! You can choose to sign in to your account first while we email the club's director");
          } else {
            return this.$set(this, 'error', null);
          }
        });
    },
  },
  mounted() {
    this.fetchCountries();
  }
};

</script>
