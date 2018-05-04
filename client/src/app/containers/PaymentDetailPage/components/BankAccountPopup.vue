<template>
  <div class="addPaymentPopup" :class="[loading == true ? 'loading' : '', success == true ? 'success' : '']">
    <div class="row col-md-12 header">
      <div class="col-md-8 buttons-inner buttons-left">
        <button class="ft-button" @click="closeAction()">Close
          <span v-if="success">✓</span>
        </button>
      </div>
    </div>
    <loading class="loader" />
    <div class="content">
      <div class="row col-md-12 buttons-inner" v-if="info == null">
        <label class="col-md-12">Please insert your information first</label>
        <button class="ft-button col-md-12" @click="PersonalInformationAction">Insert</button>
      </div>
      <form class="ft-form" method="post" v-on:submit.prevent v-if="info != null">
        <div class="row col-md-12" v-if="errors">
          <ul v-if="errors.error" class="error">
            <li>{{errors.error.message}}</li>
          </ul>
        </div>
        <div class="row col-md-12">
          <label class="col-md-4 required">Select Country</label>
          <countryselect class="col-md-8" v-on:update:val="bankInfo.country = $event;" v-on:update:obj="bank_need = $event.bank_column_needed;"
            :value="this.bankInfo.country" />
        </div>
        <div class="row col-md-12" v-if="bank_need">
          <div class="row col-md-6">
            <label class="col-md-12">Account holder name</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.account_holder_name" placeholder="Mike eagels">
          </div>
          <div class="row col-md-6">
            <label class="col-md-12">Account holder type</label>
            <vselect v-model="type_select" @input="bankInfo.account_holder_type = type_select ? type_select.value : ''" :options="options_type"
              class="ft-input col-md-12" placeholder="Please select a type" />
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('routing_number') >= 0">
            <label class="col-md-12">Routing number</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.routing_number">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('bsb') >= 0">
            <label class="col-md-12">BSB</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.bsb">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('clearing_code') >= 0">
            <label class="col-md-12">Clearing code</label>
            <input type="number" class="col-md-12 form-control" v-model="bankInfo.clearing_code">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('bank_code') >= 0">
            <label class="col-md-12">Bank code</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.bank_code">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('branch_code') >= 0">
            <label class="col-md-12">Branch code</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.branch_code">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('bank_name') >= 0">
            <label class="col-md-12">Bank name</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.bank_name">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('branch_name') >= 0">
            <label class="col-md-12">Branch name</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.branch_name">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('account_number') >= 0">
            <label class="col-md-12">Account number</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.account_number">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('sort_code') >= 0">
            <label class="col-md-12">Sort code</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.sort_code">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('iban') >= 0">
            <label class="col-md-12">Iban</label>
            <input type="text" class="col-md-12 form-control" v-model="bankInfo.iban" placeholder="CNXX XXXX XXXX XXXX">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('transit_number') >= 0">
            <label class="col-md-12">Transit number</label>
            <input type="number" class="col-md-12 form-control" v-model="bankInfo.transit_number">
          </div>
          <div class="row col-md-6" v-if="bank_need.indexOf('institution_number') >= 0">
            <label class="col-md-12">Institution number</label>
            <input type="number" class="col-md-12 form-control" v-model="bankInfo.institution_number">
          </div>
          <div class="col-md-8 buttons-inner">
            <button @click="createBank" class="ft-button">Submit</button>
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

import vSelect from 'vue-select';

export default {
  name: 'BankAccountPopup',
  props: ['closeAction','PersonalInformationAction', 'loading', 'success', 'submit', 'info', 'errors'],
  components: {
    countryselect: CountrySelect,
    loading: Loading,
    vselect: vSelect
  },
  data() {
    return {
      bank_need: null,
      bankInfo: {
        country: null,
        currency: null
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
      type_select: null
    };
  },
  mounted() {
    if (this.info) {
      this.bankInfo.currency = this.info.default_currency;
    }
  },
  watch: {
    info() {
      if (this.info) {
        this.bankInfo.currency = this.info.default_currency;
      }
    }
  },
  methods: {
    createBank() {
      this.setRoutingNumber();
      this.submit(this.bankInfo, null, 'bank_account');
    },
    setRoutingNumber() {
      switch (this.bankInfo.country) {
        case 'CA':
          this.bankInfo.routing_number =
            this.bankInfo.transit_number + this.bankInfo.institution_number;
          break;
      }
    }
  }
};
</script>
