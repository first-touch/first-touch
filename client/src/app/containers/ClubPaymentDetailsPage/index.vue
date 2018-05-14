<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">Payments Details Page </h4>
        <actions :AddPayment="AddPayment">
        </actions>
        <timeline-item>
          <cardslist :stripeClubCards="stripeClubCards"></cardslist>
        </timeline-item>
        <b-modal id="metaModal" size="md" ref="metaModal" class="formModal">
          <paymentpopup :paymentAction="paymentAction" :closeAction="hideModal" :result="stripeClubCard" :StripeCardToken="StripeCardToken" :stripePayment="createClubsCard"
            :stripeJs="stripeJs" />
        </b-modal>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/modal';
</style>


<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import TimelineItem from 'app/components/TimelineItem';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import CardsList from './components/CardsList.vue';
  import Actions from './components/Actions';
  import PaymentPopup from 'app/components/Stripe/PaymentPopup';

  export default {
    name: 'ClubPaymentDetailsPage',
    components: {
      sidebar: NotificationSidebar,
      'timeline-item': TimelineItem,
      actions: Actions,
      cardslist: CardsList,
      paymentpopup: PaymentPopup
    },
    data() {
      return {
        selected: null
      };
    },
    computed: {
      ...mapGetters(['stripeClubCards', 'stripeClubCard']),
      cards() {
        // return this.clubCards.status === ASYNC_SUCCESS? this.clubCards.value : []
      }
    },
    mounted() {
      this.getClubsCards();
    },
    methods: {
      ...mapActions(['getClubsCards', 'createClubsCard']),
      AddPayment(){
        this.$refs.metaModal.show();
      }
    }
  };
</script>
