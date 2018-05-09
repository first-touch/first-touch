<template>
  <div class="addPaymentPopup" :class="[loading == true ? 'loading' : '', success == true ? 'success' : '']">
    <div class="row col-md-12 header">
      <div class="col-md-8 buttons-inner">
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
    <form class="ft-form" action="/create-account" method="post" v-on:submit.prevent="prepareSubmit">
      <div class="row col-md-12" v-if="errors">
        <ul v-if="errors.error" class="error stripeErrors">
          <li>{{errors.error.message}}</li>
        </ul>
        <ul v-if="errors.errors" class="error ftouchErrors">
          <li>{{errors.errors.message}}</li>
        </ul>
      </div>
      <input type="hidden" name="token" id="token">
      <div class="row col-md-12">
        <label class="col-md-4 required">Select Country</label>
        <countryselect class="col-md-8" :disabled="lock" v-on:update:val="country = $event; getRequired()" :value="this.country"
        />
      </div>
      <div class="row col-md-12">
        <label class="col-md-4 required">Select Entity Type</label>
        <div class="col-md-8">
          <vselect v-model="type_select" :disabled="lock" @input="legal_entity.type = type_select ? type_select.value : ''" :options="options_type"
            class="ft-input" placeholder="Please select a type" />
        </div>
      </div>
      <div class="legal-entity" v-if="required">

        <div class="row row-form col-md-12">
          <div class="col-md-6" v-if="required.indexOf('legal_entity.first_name') >= 0">
            <label class="col-md-12 required">First Name</label>
            <input class="form-control col-md-12" required name="first_name" v-model="legal_entity.first_name">
          </div>
          <div class="col-md-6" v-if="required.indexOf('legal_entity.last_name') >= 0">
            <label class="col-md-12 required">Last Name</label>
            <input class="form-control col-md-12" required name="last_name" v-model="legal_entity.last_name">
          </div>
          <div class="col-md-6" v-if="required.indexOf('legal_entity.business_name') >= 0">
            <label class="col-md-12 required">Business Name</label>
            <input class="form-control col-md-12" required name="business_name" v-model="legal_entity.business_name">
          </div>
        </div>
        <div class="row row-form col-md-12" v-if="required.indexOf('legal_entity.additional_owners') >= 0">
          <label class="col-md-12 required">Company Owners</label>
          <div class="row col-md-12" v-for="(owner, index) in owners" :key="owner.id">
            <div class="col-md-5">
              <label class="col-md-12 required">First Name</label>
              <input type="text" class="form-input col-md-12" v-model="owner.first_name">
            </div>
            <div class="col-md-5">
              <label class="col-md-12 required">Last Name</label>
              <input type="text" class="form-input col-md-12" v-model="owner.last_name">
            </div>
            <div class="remove col-md-2" v-if="owners.length > 1" @click="removeOwners(index)">
              <icon name='trash'></icon>
            </div>
          </div>
          <button class="button row add-match" @click="addOwners">Add Owners</button>
        </div>
        <div class="row row-form col-md-12">
          <div class="col-md-6" v-if="required.indexOf('legal_entity.dob.year') >= 0">
            <label class="col-md-12 required">Date of birth</label>
            <ftdatepicker class="form-control col-md-12 ftdatepicker" required :disabled="dpconf.disabled" v-on:update:val="dob = $event"
              :value="dpconf.disabled.from" />
          </div>
          <div class="col-md-6" v-if="required.indexOf('legal_entity.personal_id_number') >= 0">
            <label class="col-md-12 required">Personal Id Number</label>
            <input class="form-control col-md-12" name="personal_id_number" required v-model="legal_entity.personal_id_number">
          </div>
          <div class="col-md-6" v-if="required.indexOf('legal_entity.business_tax_id') >= 0">
            <label class="col-md-12 required">Business tax id</label>
            <input class="form-control col-md-12" name="personal_id_number" required v-model="legal_entity.business_tax_id">
          </div>
          <div class="col-md-6" v-if="required.indexOf('legal_entity.ssn_last_4') >= 0">
            <label class="col-md-12 required">SSN last 4</label>
            <input class="form-control col-md-12" name="ssn_last_4" type="number" required max="9999" v-model="legal_entity.ssn_last_4">
          </div>
        </div>

        <div class="row row-form col-md-12" v-if="required.indexOf('legal_entity.address.city') >= 0">
          <label class="col-md-12 required">Address</label>
          <div class="row col-md-12">
            <div class="col-md-6" v-if="required.indexOf('legal_entity.address.state') >= 0">
              <label class="col-md-12 required">State</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.address.state">
            </div>
            <div class="col-md-6">
              <label class="col-md-12 required">City</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.address.city">
            </div>
          </div>
          <div class="row col-md-12">
            <div class="col-md-6" v-if="required.indexOf('legal_entity.address.line1') >= 0">
              <label class="col-md-12 required">Address Line</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.address.line1">
            </div>
            <div class="col-md-6" v-if="required.indexOf('legal_entity.address.postal_code') >= 0">
              <label class="col-md-12 required">Postal Code</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.address.postal_code">
            </div>
          </div>
        </div>
        <div class="row row-form col-md-12" v-if="required.indexOf('legal_entity.personal_address.city') >= 0">
          <label class="col-md-12 required">Personnal Address</label>
          <div class="row col-md-12">
            <div class="col-md-6" v-if="required.indexOf('legal_entity.personal_address.state') >= 0">
              <label class="col-md-12 required">State</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.personal_address.state">
            </div>
            <div class="col-md-6">
              <label class="col-md-12 required">City</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.personal_address.city">
            </div>
          </div>
          <div class="row col-md-12">
            <div class="col-md-6" v-if="required.indexOf('legal_entity.personal_address.line1') >= 0">
              <label class="col-md-12 required">Address Line</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.personal_address.line1">
            </div>
            <div class="col-md-6" v-if="required.indexOf('legal_entity.personal_address.postal_code') >= 0">
              <label class="col-md-12 required">Postal Code</label>
              <input class="col-md-12 form-control" name="line1" required v-model="legal_entity.personal_address.postal_code">
            </div>
          </div>
        </div>
        <div class="row col-md-12">

          <p>By submitting, you agree to the
            <a href="https://stripe.com/connect-account/legal">Stripe Connected Account Agreement</a>.</p>
        </div>
        <div class="col-md-8 buttons-inner">
          <button class="ft-button">Submit</button>
        </div>
      </div>

    </form>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/form';
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
    .ftdatepicker {
      padding: 0;
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
import { ASYNC_SUCCESS, ASYNC_LOADING, ASYNC_FAIL } from 'app/constants/AsyncStatus';

import vSelect from 'vue-select';

export default {
  name: 'PersonalInformationPopup',
  props: ['submit', 'stripeRequired', 'stripe', 'closeAction', 'stripeFtouch', 'getCountryInfo'],
  components: {
    ftdatepicker: FtDatepicker,
    countryselect: CountrySelect,
    vselect: vSelect,
    loading: Loading,
    icon: Icon
  },
  data() {
    return {
      country: '',
      oldCountry: '',
      owners: [
        {
          first_name: '',
          last_name: ''
        }
      ],
      dpconf: {
        disabled: {
          from: new Date()
        }
      },
      options_type: [
        {
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
      legal_entity: {
        // personal_id_number: '',
        // ssn_last_4: '',
        dob: {
          day: '',
          month: '',
          year: ''
        },
        type: '',
        first_name: '',
        last_name: '',
        address: {
          line1: '',
          city: '',
          // state: 'N/A',
          postal_code: ''
        },
        personal_address: {
          line1: '',
          city: '',
          postal_code: ''
        }
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
    errors() {
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
    info() {
      this.refactorInfo();
    },
    dob() {
      this.legal_entity.dob = Object.assign({}, this.legal_entity.dob, {
        day: this.dob.getDay() + 1,
        month: this.dob.getMonth() + 1,
        year: this.dob.getFullYear()
      });
    }
  },
  beforeMount() {
    var date = new Date();
    date.setFullYear(date.getFullYear() - 18);
    this.dob = date;
    this.dpconf.disabled.from = date;
    this.refactorInfo();
  },
  methods: {
    getRequired() {
      if (this.country != '') {
        this.getCountryInfo(this.country);
      }
    },
    prepareSubmit: function() {
      this.start = true;
      this.legal_entity.dob = Object.assign({}, this.legal_entity.dob, {
        day: this.dob.getDay() + 1,
        month: this.dob.getMonth() + 1,
        year: this.dob.getFullYear()
      });
      var obj = {
        legal_entity: this.legal_entity,
        tos_shown_and_accepted: true
      };
      this.submit(obj, this.country, 'account');
    },
    removeOwners: function(index) {
      this.owners.length > 1 ? this.owners.splice(index, 1) : '';
    },
    addOwners: function() {
      this.owners.push({
        first_name: '',
        last_name: ''
      });
    },
    refactorInfo() {
      if (this.info) {
        this.legal_entity.first_name = this.info.legal_entity.first_name;
        this.legal_entity.last_name = this.info.legal_entity.last_name;
        this.legal_entity.type = this.info.legal_entity.type;
        this.country = this.info.country;
        if (this.info.country) {
          this.lock = true;
          var index = this.$options.filters.searchInObj(
            this.options_type,
            option => option.value === this.legal_entity.type
          );
          this.type_select = this.options_type[index];
        }
        if (this.info.legal_entity.personal_id_number)
          this.legal_entity.personal_id_number = this.info.legal_entity.personal_id_number;
        if (this.info.legal_entity.address.line1)
          this.legal_entity.address.line1 = this.info.legal_entity.address.line1;
        if (this.info.legal_entity.address.city)
          this.legal_entity.address.city = this.info.legal_entity.address.city;
        if (this.info.legal_entity.address.state)
          this.legal_entity.address.state = this.info.legal_entity.address.state;
        if (this.info.legal_entity.address.postal_code)
          this.legal_entity.address.postal_code = this.info.legal_entity.address.postal_code;
        if (this.info.legal_entity.business_name)
          this.legal_entity.business_name = this.info.legal_entity.business_name;
        this.$forceUpdate();
      }
    }
  }
};
</script>
