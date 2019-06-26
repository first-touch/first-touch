<template>
  <div class="addPaymentPopup" :class="{ 'loading': loading , 'success': success }">
    <div class="row col-lg-12 header">
      <div class="col-lg-8 buttons-inner">
        <button class="ft-button ft-button-right" @click="closeAction()">Close
          <span v-if="success">✓</span>
        </button>
      </div>
    </div>
    <div class="divSuccess" v-if="success">
      <ul class="success">
        <li>
          Account successfully created !
        </li>
      </ul>
    </div>
    <loading class="loader" />
    <form class="ft-form" v-on:submit.prevent="prepareSubmit">
      <div class="row col-lg-12" v-if="serverErrors">
        <ul v-if="serverErrors.error" class="error stripeErrors">
          <li>{{serverErrors.error.message}}</li>
        </ul>
        <ul v-if="serverErrors.errors" class="error ftouchErrors">
          <li>{{serverErrors.errors}}</li>
        </ul>
      </div>
      <input type="hidden" name="token" id="token">
      <div class="row col-lg-12">
        <label class="col-lg-4 required">Select Country</label>
        <country-select class="col-lg-8" :disabled="lock" v-on:update:val="country = $event; getRequired()" :value="this.country"
        />
      </div>
      <div class="row col-lg-12">
        <label class="col-lg-4 required">Select Entity Type</label>
        <div class="col-lg-8">
          <vselect v-model="type_select" :disabled="lock" @input="legal_entity.type = type_select ? type_select.value : ''" :options="options_type"
            class="ft-input  form-control" placeholder="Please select a type" />
        </div>
      </div>
      <div class="legal-entity" v-if="required">
        <stripe-profile
            :requirements="required"
            v-model="profile" />
        <div class="row col-lg-12">
          <p>By submitting, you agree to the
            <a href="https://stripe.com/connect-account/legal">Stripe Connected Account Agreement</a>.
          </p>
        </div>
        <div class="col-lg-12 buttons-inner row">
          <button class="ft-button ft-button-success ft-button-right">Submit</button>
          <button class="ft-button ft-button-danger " v-if="info && info.legal_entity" @click="deleteAccount">Delete account</button>
        </div>
      </div>
    </form>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/form';
</style>
<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .addPaymentPopup {
    .loader {
      display: none;
      margin-left: 40%;
    }
    .header {
      display: flex;
      flex-direction: row-reverse;
    }
    form {
      .legal-entity {
        margin-top: 30px;
      }
      .row-form {
        margin-top: 20px;
      }
      .buttons-inner {
        margin-top: 30px;
      }
      .remove {
        flex-grow: 1;
        margin-top: auto;
        cursor: pointer;
        &:hover {
          color: red;
        }
      }
      .add-match {
        margin: 10px 0 0 0;
        padding: 4px;
        min-height: 20px;
        font-size: 10px;
        color: white;
        color: $main-text-color;
        border: 1px solid $main-text-color;
        border-radius: 4px;
        background-color: $button-background;
        cursor: pointer;
        &:hover {
          background-color: $button-background-hover;
        }
      }
    }
    &.loading,
    &.success {
      form {
        display: none;
      }
    }
    &.loading {
      .loader {
        display: block;
      }
    }
  }
</style>

<script>
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import CountrySelect from 'app/components/Stripe/CountrySelect';
  import Loading from 'app/components/Loading';
  import 'vue-awesome/icons/trash';
  import Icon from 'vue-awesome/components/Icon';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';
  import StripeProfile from "./StripeProfile.vue"

  import vSelect from 'vue-select';

  export default {
    name: 'PersonalInformationPopup',
    props: ['submit', 'stripeRequired', 'stripe', 'closeAction', 'stripeFtouch', 'getCountryInfo','deleteAccount'],
    components: {
      ftdatepicker: FtDatepicker,
      CountrySelect,
      vselect: vSelect,
      Loading,
      Icon,
      StripeProfile
    },
    data() {
      return {
        country: '',
        oldCountry: '',
        owners: [{
          first_name: '',
          last_name: ''
        }],
        dpconf: {
          disabled: {
            from: new Date()
          }
        },
        options_type: [{
            label: 'Individual',
            value: 'individual'
          },
          {
            label: 'Company',
            value: 'company'
          }
        ],
        type_select: null,
        dob: new Date(),
        lock: false,
        profile: {},
        legal_entity: {
          type: '',
        },
        token: '',
        stripeinfo: null,
        start: false
      };
    },
    computed: {
      required() {
        if (this.stripeRequired.status == ASYNC_SUCCESS && this.legal_entity.type)
          return this.stripeRequired.value.verification_fields[this.legal_entity.type].minimum;
        return null;
      },
      loading() {
        return (
          this.stripe.status == ASYNC_LOADING ||
          this.stripeFtouch.status == ASYNC_LOADING ||
          this.stripeRequired.status == ASYNC_LOADING
        );
      },
      serverErrors() {
        if (this.stripe.status == ASYNC_FAIL) return this.stripe.errors;
        if (this.stripeFtouch.status == ASYNC_FAIL) return this.stripeFtouch.errors;
      },
      success() {
        return (
          this.start &&
          this.stripe.status == ASYNC_SUCCESS &&
          this.stripeFtouch.status == ASYNC_SUCCESS
        );
      },
      info() {
        if (this.stripeFtouch.status == ASYNC_SUCCESS) return this.stripeFtouch.value;
        return null;
      },
      complete() {
        return this.success && this.start;
      }
    },
    watch: {
      stripeFtouch: {
        deep: true,
        immediate: true,
        handler: function(){
          this.refactorInfo();
        }
      }
    },
    beforeMount() {
      //var date = new Date();
      //date.setFullYear(date.getFullYear() - 18);
      //this.dob = date;
      this.refactorInfo();
    },
    methods: {
      getRequired() {
        if (this.country != '') {
          this.getCountryInfo(this.country);
        }
      },
      prepareSubmit: function () {
        this.start = true;
        this.profile.dob = Object.assign({}, this.profile.dob, {
          day: this.dob.getDay() + 1,
          month: this.dob.getMonth() + 1,
          year: this.dob.getFullYear()
        });
        var obj = {
          business_type: this.legal_entity.type,
          tos_shown_and_accepted: true
        };
        if (obj.business_type == "individual"){
          obj['individual'] = this.profile.individual
        } else if (obj.business_type == "company") {
          obj['company'] = this.profile.company
        }
        this.submit(obj, this.country, 'account');
      },
      removeOwners: function (index) {
        this.owners.length > 1 ? this.owners.splice(index, 1) : '';
      },
      addOwners: function () {
        this.owners.push({
          first_name: '',
          last_name: ''
        });
      },
      refactorInfo() {
        if (this.info && this.info.type) {
          this.legal_entity.type = this.info.type;
          if (this.info.profile && this.info.profile.individual){
            this.profile.individual = this.info.profile.individual;
          }
          if (this.info.profile && this.info.profile.company){
            this.profile.company = this.info.profile.company;
          }
          this.country = this.info.country;
          if (this.info.country) {
            this.lock = true;
            var index = this.$options.filters.searchInObj(
              this.options_type,
              option => option.value === this.legal_entity.type
            );
            this.type_select = this.options_type[index];
          }
          this.$forceUpdate();
        }
      }
    }
  };
</script>
