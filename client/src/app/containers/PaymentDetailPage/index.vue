<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <b-modal ref="metaModal" id="metaModal" size="lg">
        <personalinformationpopup v-if="personalInformation" :submit="custonNewStripe" :loading="loading" :success="success" :stripeRequired="stripeRequired"
          :closeAction="closeAction" :info="info" :getRequiredInfo="getStripeRequiredInfo" />
          <bankaccountpopup v-if="bank" :PersonalInformationAction="PersonalInformation" :closeAction="closeAction" :loading="loading" :success="success" :submit="custonNewStripe" :info="info" :errors="errors"/>
      </b-modal>
      <div class="ft-page">
        <actions class="widget" :PersonalInformation="PersonalInformation" :AddPayment="AddPayment" />
        <h4 class="header">Payment Details</h4>
        <timeline-item>
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

export default {
  name: 'PaymentDetailPage',
  components: {
    sidebar: NotificationSidebar,
    actions: Actions,
    'timeline-item': TimelineItem,
    personalinformationpopup: PersonalInformationPopup,
    bankaccountpopup:BankAccountPopup
  },
  data() {
    return {
      bank: false,
      personalInformation: false,
      loading: false,
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
      console.log(this.stripe)
      if (this.stripe.saving)
        switch (this.stripe.status) {
          case ASYNC_SUCCESS:
            this.loading = false;
            this.saveStripe({
              token: this.stripe.value.token.id,
              type: this.stripe.value.token.type,
              country: this.country
            });
            break;
          case ASYNC_LOADING:
            this.loading = true;
            break;
          case ASYNC_FAIL:
            this.loading = false;
            this.errors = this.stripe.errors;
            break;
        }
      else
        switch (this.stripe.status) {
          case ASYNC_SUCCESS:
            this.info = this.stripe.value;
            this.loading = false;
            break;
          case ASYNC_LOADING:
            this.loading = true;
            break;
          case ASYNC_FAIL:
            this.info = null;
            this.loading = false;
            this.errors = this.stripe.errors;
            break;
        }
    },
    stripeFtouch() {
      this.errors = false;
      switch (this.stripeFtouch.status) {
        case ASYNC_SUCCESS:
          this.loading = false;
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
          this.stripeRequired = this.stripeRequiredFields.value.verification_fields;
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
    ...mapGetters(['stripe', 'stripeFtouch', 'stripeRequiredFields'])
  },
  methods: {
    ...mapActions(['newStripeToken', 'saveStripe', 'getStripe', 'getStripeRequiredInfo']),
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
      this.newStripeToken({ data, tokenType });
    },
    closeAction() {
      this.$refs.metaModal.hide();
    }
  }
};
</script>
