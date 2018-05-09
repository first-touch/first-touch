<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <b-modal ref="metaModal" id="metaModal" size="lg" @hide="flushEdit()">
        <personalinformationpopup v-if="personalInformation" :submit="custonNewStripe" :stripeRequired="stripeRequiredFields" :stripe="stripe" :stripeFtouch="stripeFtouch"
          :closeAction="closeAction" :getCountryInfo="getStripeRequiredInfo" />
        <bankaccountpopup v-if="bank" :PersonalInformationAction="PersonalInformation" :closeAction="closeAction" :stripeRequired="stripeRequiredFields"
          :stripe="stripe" :stripeFtouch="stripeFtouch" :submit="custonNewStripe" :getCountryInfo="getStripeRequiredInfo" />
      </b-modal>
      <b-modal class="ft-modal" ref="DeleteBankModal" size="md" @hide="flushDelete()">
        <confirmdelete v-if="selectedBankAccount" :bankAccount="selectedBankAccount" :stripeDelete="stripeDelete" :deleteAction="deleteBankAccountAction"
          :closeAction="closeAction" />
      </b-modal>
      <div class="ft-page">
        <actions class="widget" :PersonalInformation="PersonalInformation" :AddPayment="AddPayment" />
        <h4 class="header">Payment Details</h4>
        <timeline-item>
          <bankaccountlist :stripe="stripeFtouch" :deleteBank="deleteBank" :preferredBank="preferredBank" />
        </timeline-item>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/modal';
@import '~stylesheets/variables';
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.widget {
  margin-bottom: 20px;
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS, ASYNC_LOADING, ASYNC_FAIL } from 'app/constants/AsyncStatus';
import TimelineItem from 'app/components/TimelineItem';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import Actions from './components/Actions';
import PersonalInformationPopup from './components/PersonalInformationPopup';
import BankAccountPopup from './components/BankAccountPopup';
import BankAccountList from './components/BankAccountList';
import ConfirmDelete from './components/ConfirmDelete';

export default {
  name: 'PaymentDetailPage',
  components: {
    sidebar: NotificationSidebar,
    actions: Actions,
    'timeline-item': TimelineItem,
    personalinformationpopup: PersonalInformationPopup,
    bankaccountpopup: BankAccountPopup,
    bankaccountlist: BankAccountList,
    confirmdelete: ConfirmDelete
  },
  data() {
    return {
      bank: false,
      personalInformation: false,
      selectedBankAccount: null,
      loading: false,
      loadingAccount: false,
      success: false,
      errors: null,
      info: null,
      country: null,
      stripeRequired: null
    };
  },
  watch: {
    stripe() {
      this.errors = false;
      console.log(this.stripe);
      if (this.stripe.saving)
        switch (this.stripe.status) {
          case ASYNC_SUCCESS:
            this.saveStripe({
              token: this.stripe.value.token.id,
              type: this.stripe.value.token.type,
              country: this.country
            });
            break;
          case ASYNC_LOADING:
            this.loading = this.loadingAccount = true;
            break;
          case ASYNC_FAIL:
            this.loading = false;
            this.errors = this.stripe.errors;
            break;
        }
      else
        switch (this.stripe.status) {
          case ASYNC_SUCCESS:
            this.loadingAccount = false;
            break;
          case ASYNC_LOADING:
            this.loadingAccount = true;
            break;
          case ASYNC_FAIL:
            this.info = null;
            this.loadingAccount = false;
            this.errors = this.stripe.errors;
            break;
        }
    },
    stripeFtouch() {
      this.errors = false;
      this.info = null;
      switch (this.stripeFtouch.status) {
        case ASYNC_SUCCESS:
          this.loading = false;
          this.info = this.stripe.value;
          this.success = true;
          break;
        case ASYNC_LOADING:
          this.loading = true;
          break;
        case ASYNC_FAIL:
          this.loading = false;
          this.errors = this.stripe.errors;
          break;
      }
    },
    stripeRequiredFields() {
      switch (this.stripeRequiredFields.status) {
        case ASYNC_SUCCESS:
          this.loading = false;
          this.stripeRequired = this.stripeRequiredFields.value;
          break;
        case ASYNC_LOADING:
          this.loading = true;
          break;
        case ASYNC_FAILURE:
          this.loading = false;
          this.errors = this.stripe.errors;
          break;
      }
    }
  },
  mounted() {
    this.getStripe();
  },
  computed: {
    ...mapGetters(['stripe', 'stripeFtouch', 'stripeRequiredFields', 'stripeDelete']),
    stripeAccount() {},
    stripeAddBank() {}
  },
  methods: {
    ...mapActions([
      'newStripeToken',
      'saveStripe',
      'getStripe',
      'getStripeRequiredInfo',
      'deleteStripe',
      'flushDelete',
      'flushStripe'
    ]),
    PersonalInformation() {
      this.personalInformation = true;
      this.bank = false;
      this.$refs.metaModal.show();
    },
    AddPayment() {
      this.bank = true;
      this.personalInformation = false;
      this.$refs.metaModal.show();
    },
    custonNewStripe(data, country, tokenType) {
      this.country = country;
      this.newStripeToken({
        data,
        tokenType
      });
    },
    deleteBankAccountAction() {
      var obj = {
        type: 'bank_account',
        id: this.selectedBankAccount.id
      };
      this.deleteStripe(obj);
    },
    deleteBank(bankInfo) {
      this.selectedBankAccount = bankInfo;
      console.log(bankInfo);
      this.$refs.DeleteBankModal.show();
    },
    flushEdit() {
      this.bank = false;
      this.personalInformation = false;
    },
    preferredBank(bankInfo) {},
    closeAction() {
      this.$refs.metaModal.hide();
      this.$refs.DeleteBankModal.hide();
    }
  }
};
</script>
