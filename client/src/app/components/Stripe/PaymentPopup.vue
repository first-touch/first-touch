<template>
  <div class="payment-widget ft-form" :class="loading ? 'loading' : ''">
    <div class="contentPayment">
      <loading class="loader" />
      <div class="payment" v-if="!success">
        <slot name="header"></slot>
        <vselect v-model="cardSelect" v-if="!newCard" @input="cardToken = cardSelect.value" :options="cards" :searchable="false"
        />
        <div class="card-input" :class="!newCard? 'hide' : ''">
          <div ref="card" class="form-control"></div>
        </div>
        <div class="error" v-if="errors">
          <ul>
            <li>{{result.errors.errors}}</li>
          </ul>
        </div>
        <div class="img-container col-sm-4">
          <img class="img-fluid" src="/images/stripe/secure-stripe-payment-logo.png" alt="Stripe secure" />
        </div>
        <div :class="!newCard? 'hide' : ''" class="col-md-12">
          <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="saveCard? 'active' : ''">
            <span class="title" v-if="saveCard"> Save the card for further use</span>
            <span class="not" v-if="!saveCard"> Do not save the card for further use</span>
            <ftcheckbox class="ftcheckbox" :value="saveCard" v-on:update:val="saveCard = $event" :trueValue="true" :falseValue="false"
            />
          </label>
        </div>
        <slot />

        <div class="buttons-inner col-sm-8">

          <button class="ft-button-success  ft-button-right" v-on:click="purchase">Purchase</button>
          <button class="ft-button" v-if="!emptyCard" v-on:click="newCard = !newCard">
            <span v-if="!newCard">Add a new card </span>
            <span v-if="newCard">Use existing card</span>
          </button>
          <button class="ft-button" @click="closeAction()" :class="success?'ft-button-success':''">Close</button>
        </div>

      </div>
      <div v-if="success">
        <p>Success !</p>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  .payment-widget {
    .selected-tag {
      color: red;
    }
  }

  .card-input {
    .form-control {
      padding: 10px;
      border-radius: 10px;
    }
    iframe {
      height: auto;
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

  .payment-widget {
    padding: 0 10px 20px 10px;
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
      var style = {
        base: {
          lineHeight: '40px',
          fontWeight: 300,
          fontFamily: 'Ubuntu, sans-serif',
          fontSize: '15px',
        }
      };
      this.card = this.elements.create('card', {
        style: style
      });
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
