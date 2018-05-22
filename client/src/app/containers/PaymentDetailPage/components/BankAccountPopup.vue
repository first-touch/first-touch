<template>
  <div class="addPaymentPopup" :class="[loading == true ? 'loading' : '', complete == true ? 'success' : '']">
    <div class="row col-md-12 header">
      <div class="col-md-8 buttons-inner buttons-left">
        <button class="ft-button ft-button-right" @click="closeAction()">Close
          <span v-if="complete">✓</span>
        </button>
      </div>
    </div>
    <loading class="loader" />
    <div class="divSuccess" v-if="complete">
      <ul class="success">
        <li>
          Account successfully added !
        </li>
      </ul>
    </div>
    <div class="content">
      <form class="ft-form" v-on:submit.prevent="createBank(); start = true;" v-if="info != null">
        <div class="row col-md-12" v-if="errors">
          <ul v-if="errors.error" class="error">
            <li>{{errors.error.message}}</li>
          </ul>
        </div>
        <div class="row col-md-12">
          <label class="col-md-4 required">Select Country</label>
          <countryselect :filter="availableCountry" class="col-md-8" v-on:update:val="bankInfo.country = $event; getRequired();" v-on:update:obj="bankNeed = $event ? $event.bank_column_needed : null"
            :value="this.bankInfo.country" />
        </div>
        <div class="row col-md-12" v-if="bankNeed">
          <div class="row col-md-6">
            <label class="col-md-12 required">Account holder name</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.account_holder_name" placeholder="Mike eagels">
          </div>
          <div class="row col-md-6">
            <label class="col-md-12 required">Account holder type</label>
            <vselect v-model="typeSelect" required @input="bankInfo.account_holder_type = typeSelect ? typeSelect.value : ''" :options="optionsType"
              class="ft-input col-md-12" placeholder="Please select a type" />
          </div>
          <div class="row col-md-6 " v-if="bankNeed.indexOf('routing_number') >= 0">
            <label class="col-md-12 required">Routing number</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.routing_number">
          </div>
          <div class="row col-md-6" v-if="bankNeed.indexOf('bsb') >= 0">
            <label class="col-md-12 required">BSB</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.bsb">
          </div>
          <div class="row col-md-6" v-if="bankNeed.indexOf('clearing_code') >= 0">
            <label class="col-md-12 required">Clearing code</label>
            <input type="number" class="col-md-12 form-control" required v-model="bankInfo.clearing_code">
          </div>
          <div class="row col-md-6" v-if="bankNeed.indexOf('bank_code') >= 0">
            <label class="col-md-12 required">Bank code</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.bank_code">
          </div>
          <div class="row col-md-6 " v-if="bankNeed.indexOf('branch_code') >= 0">
            <label class="col-md-12 required">Branch code</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.branch_code">
          </div>
          <div class="row col-md-6 " v-if="bankNeed.indexOf('bank_name') >= 0">
            <label class="col-md-12 required">Bank name</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.bank_name">
          </div>
          <div class="row col-md-6 " v-if="bankNeed.indexOf('branch_name') >= 0">
            <label class="col-md-12 required">Branch name</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.branch_name">
          </div>
          <div class="row col-md-6 " v-if="bankNeed.indexOf('account_number') >= 0">
            <label class="col-md-12 required">Account number</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.account_number">
          </div>
          <div class="row col-md-6" v-if="bankNeed.indexOf('sort_code') >= 0">
            <label class="col-md-12 required">Sort code</label>
            <input type="text" class="col-md-12 form-control" required v-model="bankInfo.sort_code">
          </div>
          <div class="row col-md-6" v-if="bankNeed.indexOf('iban') >= 0">
            <label class="col-md-12 required">Iban</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.iban" required placeholder="CNXX XXXX XXXX XXXX">
          </div>
          <div class="row col-md-6" v-if="bankNeed.indexOf('transit_number') >= 0">
            <label class="col-md-12 required">Transit number</label>
            <input type="number" class="col-md-12 form-control" required v-model="bankInfo.transit_number">
          </div>
          <div class="row col-md-6" v-if="bankNeed.indexOf('institution_number') >= 0">
            <label class="col-md-12 required">Institution number</label>
            <input type="number" class="col-md-12 form-control" required v-model="bankInfo.institution_number">
          </div>
          <div class="col-md-12 buttons-inner">
            <button class="ft-button ft-button-success ft-button-right">Add</button>
          </div>
        </div>
      </form>
    </div>
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

  &.loading,
  &.success {
    .content {
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
  name: 'BankAccountPopup',
  props: [
    'closeAction',
    'PersonalInformationAction',
    'submit',
    'getCountryInfo',
    'stripeRequired',
    'stripe',
    'saveStripe',
    'stripeFtouch'
  ],
  components: {
    countryselect: CountrySelect,
    loading: Loading,
    vselect: vSelect
  },
  data() {
    return {
      bankNeed: null,
      bankInfo: {
        country: null,
        currency: null
      },
      optionsType: [
        {
          label: 'Individual',
          value: 'individual'
        },
        {
          label: 'Company',
          value: 'company'
        }
      ],
      optionsCurrency: [],
      currencySelect: null,
      start: false,
      typeSelect: null,
      userCountry: null,
      availableCountry: []
    };
  },
  computed: {
    loading() {
      return (
        this.stripe.status == ASYNC_LOADING ||
        this.stripeFtouch.status == ASYNC_LOADING ||
        this.stripeRequired.status == ASYNC_LOADING
      );
    },
    errors() {
      return this.stripe.status == ASYNC_FAIL ? this.stripe.errors : null;
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
  mounted() {
    this.prepare();
  },
  watch: {
    loading() {
      this.prepare();
    },
    success() {},
    stripeRequired() {
      if (
        this.stripeRequired.status == ASYNC_SUCCESS &&
        this.stripeRequired.value.id == this.info.country
      ) {
        this.availableCountry = [];
        for (var currency in this.stripeRequired.value.supported_bank_account_currencies) {
          this.availableCountry = this.availableCountry.concat(
            this.stripeRequired.value.supported_bank_account_currencies[currency]
          );
        }
      }
    }
  },
  methods: {
    createBank() {
      this.setRoutingNumber();
      if (this.bankInfo.iban) this.bankInfo.account_number = this.bankInfo.iban;
      this.submit(this.bankInfo, null, 'bank_account');
    },
    setRoutingNumber() {
      switch (this.bankInfo.country) {
        case 'CA':
          this.bankInfo.routing_number =
            this.bankInfo.transit_number + this.bankInfo.institution_number;
          break;
        case 'BR':
        case 'JP':
          this.bankInfo.routing_number = this.bankInfo.bank_code + this.bankInfo.branch_code;
          break;
        case 'HK':
          this.bankInfo.routing_number = this.bankInfo.clearing_code + this.bankInfo.branch_code;
          break;
        case 'NZ':
          this.bankInfo.routing_number =
            this.bankInfo.routing_number + this.bankInfo.account_number;
          break;
        case 'SG':
          this.bankInfo.routing_number = this.bankInfo.bank_code + '-' + this.bankInfo.branch_code;
          break;
      }
    },
    getRequired() {
      if (this.stripeRequired.status == ASYNC_SUCCESS) {
        for (var currency in this.stripeRequired.value.supported_bank_account_currencies) {
          if (
            this.stripeRequired.value.supported_bank_account_currencies[currency].indexOf(
              this.bankInfo.country
            ) >= 0
          )
            this.bankInfo.currency = currency;
        }
      }
    },
    prepare() {
      if (!this.loading) {
        if (!this.info || !this.info.legal_entity) this.PersonalInformationAction();
        else {
          if (!this.stripeRequired.value) {
            this.getCountryInfo(this.info.country);
          }
        }
      }
    }
  }
};
</script>
