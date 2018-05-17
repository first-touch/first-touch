<template>
  <div>
    <div class="error" v-if="errors">
      Errors:
      <ul>
        <li>{{result.errors.errors}}</li>
      </ul>
    </div>
    <div class="contentPayment ft-form" :class="loading ? 'loading' : ''">
      <loading class="loader" />
      <div class="payment" v-if="!success">
        <vselect v-model="cardSelect" v-if="!newCard" @input="cardToken = cardSelect.value" :options="cards" :searchable="false"
        />
        <div :class="!newCard? 'hide' : ''">
          <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="saveCard? 'active' : ''">
            <span class="title" v-if="saveCard"> Save the card for further use</span>
            <span class="not" v-if="!saveCard"> Do not save the card for further use</span>
            <ftcheckbox class="ftcheckbox" :value="saveCard" v-on:update:val="saveCard = $event" :trueValue="true" :falseValue="false"
            />
          </label>
          <div ref="card"></div>
        </div>
        <div class="buttons-inner">
          <button class="ft-button" v-if="!emptyCard" v-on:click="newCard = !newCard">
            <span v-if="!newCard">Add a new card </span>
            <span v-if="newCard">Use existing card</span>
          </button>
          <button class="ft-button-success" v-on:click="purchase">Purchase</button>
        </div>
      </div>
      <div v-if="success">
        <p>Success !</p>
        <div class="col-md-12 buttons-inner">
          <button class="ft-button-success ft-button-right" @click="closeAction()">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  .contentPayment {
    .selected-tag {
      color: red;
    }
  }

  .hide {
    display: none;
  }
</style>


<style lang="scss" scoped>
  @import '~stylesheets/variables';

  form {
    border: 1px solid $secondary-header-color;
    padding: 20px;
  }

  .buttons-inner {
    margin-top: 20px;
  }

  .contentPayment {
    padding: 50px 10px 20px 10px;
    .loader {
      display: none;
      margin-left: 40%;
    }
    &.loading {
      .loader {
        display: block;
      }
      .payment {
        display: none;
      }
    }
    .not {
      color: #ff2121;
      text-transform: uppercase;
      letter-spacing: 3px;
      font-size: 15px;
    }
  }

  .error {
    color: red;
    ul {
      display: list-item;
      padding: 0 0 0 50px;
      li {
        display: list-item;
        list-style: disc;
      }
    }
  }
</style>

<script>
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';
  import {
    StripePublicKey
  } from 'app/constants/StripeConstant';
  import Loading from 'app/components/Loading';
  import vSelect from 'vue-select';
  import FtCheckbox from 'app/components/Input/FtCheckbox';

  export default {
    name: 'PaymentPopup',
    props: [
      'closeAction',
      'stripePayment',
      'StripeCardToken',
      'stripeJs',
      'paymentAction',
      'stripeClubCards',
      'result'
    ],
    components: {
      loading: Loading,
      vselect: vSelect,
      ftcheckbox: FtCheckbox
    },
    data() {
      return {
        card: null,
        cardSelect: null,
        cardToken: null,
        newCard: false,
        saveCard: true,
        emptyCard: false,
        start: false
      };
    },
    watch: {
      stripePayment() {
        if (this.stripePayment.status == ASYNC_SUCCESS) {
          this.paymentAction(this.token, this.saveCard, false);
          this.start = true;
        }
      },
      stripeClubCards() {
        if (this.stripeClubCards.status == ASYNC_SUCCESS)
          if (this.cards.length == 0) {
            this.emptyCard = true
            this.newCard = true
          }
        if (this.stripeClubCards.status == ASYNC_FAIL) {
          this.emptyCard = true
          this.newCard = true
        }
      }
    },
    computed: {
      token() {
        return this.stripePayment.value.token.id;
      },
      elements() {
        return this.stripeJs.elements();
      },
      loading() {
        return (
          this.result.status === ASYNC_LOADING ||
          this.stripePayment.status === ASYNC_LOADING ||
          this.stripeClubCards.status === ASYNC_LOADING
        );
      },
      success() {
        return this.result.status === ASYNC_SUCCESS && this.start;
      },
      errors() {
        return this.result.status === ASYNC_FAIL || this.stripePayment.status === ASYNC_FAIL;
      },
      stripe() {
        return this.stripeClubCards.status == ASYNC_SUCCESS ? this.stripeClubCards.value : {};
      },
      cards() {
        var options = [];
        for (var i in this.stripe.cards) {
          var card = this.stripe.cards[i];
          options.push({
            label: ` ${card.brand} **${card.last4} expire on ${card.exp_month}/${card.exp_year} `,
            value: card.id
          });
          if (card.id == this.stripe.default_source)
            this.cardSelect = {
              label: `Default: ${card.brand} **${card.last4} expire on ${card.exp_month}/${
              card.exp_year
            } `,
              value: card.id
            };
        }
        return options;
      }
    },
    mounted: function () {
      this.card = this.elements.create('card');
      this.card.mount(this.$refs.card);
    },
    methods: {
      purchase: function () {
        if (this.newCard) this.StripeCardToken(this.card);
        else {
          this.paymentAction(this.cardToken, false, true);
          this.start = true;
        }
      }
    }
  };
</script>
