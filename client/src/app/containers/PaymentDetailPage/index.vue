<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <b-modal ref="metaModal" id="metaModal" size="md">
        <addpaymentpopup :submit="newStripe" :loading="loading" :success="success" :closeAction="closeAction" :info="info" />
      </b-modal>
      <div class="ft-page">
        <actions class="widget" :AddPayment="AddPayment" />
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
import { ASYNC_SUCCESS, ASYNC_LOADING, ASYNC_FAILURE } from 'app/constants/AsyncStatus';
import TimelineItem from 'app/components/TimelineItem';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import Actions from './components/Actions';
import AddPaymentPopup from './components/AddPaymentPopup';

export default {
  name: 'PaymentDetailPage',
  components: {
    sidebar: NotificationSidebar,
    actions: Actions,
    'timeline-item': TimelineItem,
    addpaymentpopup: AddPaymentPopup
  },
  data: () => {
    return {
      loading: false,
      success: false,
      errors: null,
      info: null
    };
  },
  watch: {
    stripe() {
      this.errors = false;
      if (this.stripe.saving)
        switch (this.stripe.status) {
          case ASYNC_SUCCESS:
            this.loading = false;
            this.saveStripe({
              token: this.stripe.value.token.id
            });
            break;
          case ASYNC_LOADING:
            this.loading = true;
            break;
          case ASYNC_FAILURE:
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
          case ASYNC_FAILURE:
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
    ...mapGetters(['stripe', 'stripeFtouch'])
  },
  methods: {
    ...mapActions(['newStripe', 'saveStripe', 'getStripe']),
    AddPayment() {
      this.$refs.metaModal.show();
    },
    closeAction() {
      this.$refs.metaModal.hide();
    }
  }
};
</script>
