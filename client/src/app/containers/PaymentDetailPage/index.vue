<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <b-modal ref="metaModal" id="metaModal" size="lg" @hide="flushEdit()">
        <personalinformationpopup v-if="personalInformation" :submit="custonNewStripe" :stripeRequired="stripeRequiredFields" :stripe="stripe"
          :stripeFtouch="stripeFtouch" :closeAction="closeAction" :getCountryInfo="getStripeRequiredInfo" :deleteAccount="deleteAccount"/>
        <bankaccountpopup v-if="bank" :PersonalInformationAction="PersonalInformation" :closeAction="closeAction" :stripeRequired="stripeRequiredFields"
          :stripe="stripe" :stripeFtouch="stripeFtouch" :submit="custonNewStripe" :getCountryInfo="getStripeRequiredInfo" />
      </b-modal>
      <b-modal class="ft-modal" ref="DeleteBankModal" size="md" @hide="flushDelete()">
        <confirmdelete v-if="selectedBankAccount" :bankAccount="selectedBankAccount" :stripeFtouch="stripeFtouch"
         :deleteAction="deleteBankAccountAction" :deleteAccount="deleteAccount" :isDeleteAccount="isDeleteAccount"
          :closeAction="closeAction" />
      </b-modal>
      <div class="ft-page">
<<<<<<< HEAD
        <h4 class="header">Payment Details</h4>
=======
        <h4 class="spaced-title upper-cased main-color">Payment Details</h4>
>>>>>>> [Chore] cleaning up some more styling
        <actions class="widget" :hasStripe="hasStripe" :PersonalInformation="PersonalInformation" :AddPayment="AddPayment"  />
        <timeline-item>
          <bankaccountlist :stripe="stripeFtouch" :deleteBank="deleteBank" :deleteAccount="deleteAccount" :preferredBank="preferredBank" />
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
      serverErrors: null,
      info: null,
      country: null,
      stripeRequired: null,
      isDeleteAccount: false
    };
  },
  watch: {
    stripe() {
      this.serverErrors = false;
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
            this.serverErrors = this.stripe.errors;
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
            this.serverErrors = this.stripe.errors;
            break;
        }
    },
    stripeFtouch() {
      this.serverErrors = false;
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
          this.serverErrors = this.stripe.errors;
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
          this.serverErrors = this.stripe.errors;
          break;
      }
    }
  },
  mounted() {
    this.getStripe();
  },
  computed: {
    ...mapGetters(['stripe', 'stripeFtouch', 'stripeRequiredFields', 'stripeDelete','user']),
    hasStripe(){
      if (this.stripeFtouch.status == ASYNC_SUCCESS){
        return this.stripeFtouch.value.legal_entity
      }
      return false;
    }
  },
  methods: {
    ...mapActions([
      'newStripeToken',
      'saveStripe',
      'getStripe',
      'getStripeRequiredInfo',
      'deleteStripe',
      'flushDelete',
      'flushStripe',
      'updateStripe'
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
      var type = !this.isDeleteAccount ?'bank_account':'whole_account';
      var obj = {
        type: type,
        id: this.selectedBankAccount.id
      };
      this.deleteStripe(obj);
    },
    deleteAccount(bankInfo = null){
      this.isDeleteAccount = true;
      this.$refs.DeleteBankModal.show();
      this.selectedBankAccount = bankInfo;
    },
    deleteBank(bankInfo) {
      this.selectedBankAccount = bankInfo;
      this.$refs.DeleteBankModal.show();
    },
    flushEdit() {
      this.bank = false;
      this.personalInformation = false;
    },
    preferredBank(bankInfo) {
      var obj = {
        type: 'preferred',
        id: bankInfo.id
      };
      this.updateStripe(obj);
    },
    closeAction() {
      this.selectedBankAccount = null;
      this.$refs.metaModal.hide();
      this.$refs.DeleteBankModal.hide();
    }
  }
};
</script>
