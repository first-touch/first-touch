<template>
  <div>
    <navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>
      <div class="col col-lg-5">
        <form class="form" @submit.prevent="handleSubmit">
          <label>Your Club*</label>
            <div class="row">
              <!-- <select v-model="club_country_code" class="form-control col-md-4">
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
                /> -->
            </div>
          </fieldset>
          <button class="a-bar-button center" type="submit">Sign Up</button>
          <!-- <fieldset class="col-md-12">
            <div v-if="error" class="alert alert-danger">
              <em>{{ error }}</em>
            </div>
          </fieldset> -->
        </form>
      </div>
    </div>
  </div>
</template>

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
      clubs: []
    }
  },
  methods: {
    handleSubmit() {
      alert('hello world')
    }
  }
};

</script>
