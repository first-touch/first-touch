<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="spaced-title">Billing & Payments</h4>
        <actions :addPayment="addPayment">
        </actions>
        <timeline-item>
          <cardslist :stripeClubCards="stripeClubCards" :deleteCard="deleteCard" :updateCards="updateCards"></cardslist>
        </timeline-item>
        <b-modal id="metaModal" size="md" ref="metaModal" class="formModal" @hidden="AddCardHidden">
          <addcard :saveCard="saveCard" :closeAction="hideModal" :result="stripeClubCards" :StripeCardToken="StripeCardToken" :stripePayment="stripePayment"
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
    ASYNC_SUCCESS,
  } from 'app/constants/AsyncStatus';
  import TimelineItem from 'app/components/TimelineItem';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import CardsList from './components/CardsList.vue';
  import Actions from './components/Actions';
  import AddCard from './components/AddCard';

  export default {
    name: 'ClubPaymentDetailsPage',
    components: {
      sidebar: NotificationSidebar,
      'timeline-item': TimelineItem,
      actions: Actions,
      cardslist: CardsList,
      addcard: AddCard
    },
    data() {
      return {
        selected: null
      };
    },
    computed: {
      ...mapGetters(['stripeClubCards', 'stripeJs', 'stripePayment']),
      cards() {
        // return this.clubCards.status === ASYNC_SUCCESS? this.clubCards.value : []
      }
    },
    mounted() {
      this.getClubsCards();
    },
    methods: {
      ...mapActions(['getClubsCards', 'createClubsCard', 'StripeCardToken', 'deleteCard', 'updateCards',
        'flushStripeCardToken'
      ]),
      addPayment() {
        this.$refs.metaModal.show();
      },
      hideModal() {
        this.$refs.metaModal.hide();
      },
      AddCardHidden() {
        if (this.stripeClubCards.status == ASYNC_SUCCESS)
          this.flushStripeCardToken();
      },
      saveCard(token) {
        this.createClubsCard({
          token
        });
      }
    }
  };
</script>
