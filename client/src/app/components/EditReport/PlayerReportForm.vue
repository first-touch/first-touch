<template>
  <form @submit.prevent class="report-form">
    <div class="form-group row report-name">
      <div class="col-lg-12 required-before">
        <input type="text" class="form-control" v-model="headline" placeholder="Report name" name="name" v-validate="'required'">
        <span class="text-danger">{{ errors.first('name') }}</span>
      </div>
    </div>
    <div class="row form-group" v-if="priceEdit">
      <div class="col-lg-12">
        <div class="price-input">
          <currencyinput :value="price" placeholder="Price" />
          <input type="text" class="d-none" name="price" v-model="price.value" v-validate="'required'" maxValue="999999" />
          <span class="text-danger">{{ errors.first('price') }}</span>
          <p v-if="price.value == 0" class="info">The report will be free</p>
          <p v-if="request" class="info">Price between {{request.price.value}} and {{request.price.max}} {{request.price.currency}} </p>
        </div>
      </div>
    </div>
    <div v-if="playerEditable">
      <h5 class="menu"> Player Summary </h5>
      <div class="form-group form-inner">
        <transition name="fade">
          <div class="form-group player-summary">
            <div class="row mt-2 mb-2">
              <div class="col-lg-4 required-before">
                <input type="number" class="form-control" v-model.number="meta_data.player_info.age" :placeholder="agePlaceHolder" name="age" v-validate="'required|between:16,40'">
                <span class="text-danger">{{ errors.first('age') }}</span>
              </div>
              <div class="col-lg-4 required-before">
                <div class="input-group">
                  <input
                    type="number"
                    min="0"
                    v-model.number="meta_data.player_info.height"
                    :placeholder="heightPlaceHolder"
                    class="form-control m-field-input"
                    name="height"
                    v-validate="'required|between:150,250'"
                  >
                  <div class="input-group-append">
                    <span class="input-group-text" id="basic-addon2">cm</span>
                  </div>
                </div>
                <span class="text-danger">{{ errors.first('height') }}</span>
              </div>
              <div class="col-lg-4 required-before">
                <div class="input-group">
                  <input
                    type="number"
                    min="0"
                    v-model.number="meta_data.player_info.weight"
                    :placeholder="weightPlaceHolder"
                    class="form-control m-field-input"
                    name="weight"
                    v-validate="'required|between:50,150'"
                  >
                  <div class="input-group-append">
                    <span class="input-group-text" id="basic-addon2">Kg</span>
                  </div>
                </div>
                <span class="text-danger">{{ errors.first('weight') }}</span>
              </div>
            </div>
            <div class="row mt-2 mb-2">
              <div class="col-lg-6">
                <playerposition :value="meta_data.player_info.playing_position" v-on:update:val="meta_data.player_info.playing_position = $event" placeholder="Positions in" />
              </div>
              <div class="col-lg-6">
                <preferredfoot :value="meta_data.player_info.preferred_foot" v-on:update:val="meta_data.player_info.preferred_foot = $event"
                  placeholder="Preferred foot is" />
              </div>
            </div>
            <div class="row mt-2 mb-2">
              <div class="col-lg-6">
                <country-select :value="meta_data.player_info.nationality_country_code" v-on:update:val="meta_data.player_info.nationality_country_code = $event"
                  placeholder="Nationality is" /> </div>
              <div class="col-lg-6">
                <country-select :value="meta_data.player_info.residence_country_code" v-on:update:val="meta_data.player_info.residence_country_code = $event"
                  placeholder="Based in" />
              </div>
            </div>
            <div class="row mt-2 mb-2">
              <div class="col-lg-12">
                <language :value="meta_data.player_info.languages" v-on:update:val="meta_data.player_info.languages = $event" placeholder="Speaking languages are"/>
              </div>
            </div>
          </div>
        </transition>
      </div>
    </div>
    <h5> Transfer Summary </h5>
    <div class="form-group">
      <div class="row">
        <div class="col-lg-6">
          <label :class="meta_data.transfer_sum.transfer_interested == 'yes' ? 'active' : ''">
            <span class="title">Interested in Transfer?</span>
          </label>
          <ftcheckbox class="ftcheckbox" :value="meta_data.transfer_sum.transfer_interested" v-on:update:val="meta_data.transfer_sum.transfer_interested = $event" />
        </div>

        <div class="col-lg-6">
          <label :class="meta_data.transfer_sum.loan_interested == 'yes' ? 'active' : ''">
            <span class="title">Interested in Loan?</span>
          </label>
          <ftcheckbox class="ftcheckbox" :value="meta_data.transfer_sum.loan_interested" v-on:update:val="meta_data.transfer_sum.loan_interested = $event" />
        </div>
      </div>
    </div>
    <h5> Analysis of Trainings/Matches </h5>
    <div class="form-group">
      <div class="row">
        <matchanalyzed class="col-lg-12" :analyzed_matches="meta_data.analyzed_matches" type="player" />
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea class="form-control" v-model="meta_data.overview" v-autosize="meta_data.overview" placeholder="Current Ability Overview" />
        </div>
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea class="form-control" v-model="meta_data.physical_attributes" v-autosize="meta_data.physical_attributes" placeholder="Physical Attribute(s)" />
        </div>
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea class="form-control" v-model="meta_data.mental_attributes" v-autosize="meta_data.mental_attributes" placeholder="Mental Attribute(s)" />
        </div>
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea class="form-control" v-model="meta_data.technical_attributes" v-autosize="meta_data.technical_attributes" placeholder="Technical Attribute(s)" />
        </div>
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea type="text" class="form-control" v-model="meta_data.personality" v-autosize="meta_data.personality" placeholder="Personality" />
        </div>
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea type="text" class="form-control" v-model="meta_data.potential" v-autosize="meta_data.potential" placeholder="Potential" />
        </div>
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea type="text" class="form-control" v-model="meta_data.observations" v-autosize="meta_data.observations" placeholder="Other Observations & Viewpoints To Note" />
        </div>
      </div>
      <div class="row mb-2 mt-2">
        <div class="col-md-12">
          <textarea class="form-control" v-model="meta_data.conclusion" v-autosize="meta_data.conclusion" placeholder="Conclusion" />
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="col-lg-12">
        <addattachments :attachments="report ? report.attachments.attachments : null" v-on:update:remove="remove_attachment = $event"
          v-on:update:files="files = $event" />
      </div>
    </div>

    <div class="row float-right">
      <button v-if="!report && !request" id="submit" class="btn btn-primary mr-1" @click="handleSubmit('publish')">Publish</button>
      <button v-if="report" id="submit" class="btn btn-primary mr-1" @click="handleSubmit(report.status)">Update</button>
      <button v-if="!report && request" id="submit" class="btn btn-primary mr-1" @click="handleSubmit('private')">Send Report</button>
      <button @click="cancelAction" id="cancel" name="cancel" class="btn btn-danger">Cancel</button>
    </div>
  </form>
</template>

<script>
  import MatchAnalyzed from 'app/components/Input/MatchAnalyzed';
  import PlayerPosition from 'app/components/Input/PlayerPosition';
  import CountrySelect from 'app/components/Input/CountrySelect';
  import Language from 'app/components/Input/Language';
  import PreferredFoot from 'app/components/Input/PreferredFoot';
  import FtCheckbox from 'app/components/Input/FtCheckbox';
  import AddAttachments from 'app/components/Input/AddAttachments';
  import 'vue-awesome/icons/trash';
  import Icon from 'vue-awesome/components/Icon';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import FtDatepicker from 'app/components/Input/FtDatepicker';

  export default {
    name: 'PlayerReportForm',
    components: {
      matchanalyzed: MatchAnalyzed,
      playerposition: PlayerPosition,
      CountrySelect,
      language: Language,
      preferredfoot: PreferredFoot,
      ftcheckbox: FtCheckbox,
      addattachments: AddAttachments,
      icon: Icon,
      currencyinput: CurrencyInput,
      ftdatepicker: FtDatepicker
    },
    props: ['playerId', 'submitReport', 'report', 'cancelAction', 'request', 'hasBankAccount'],
    data() {
      return {
        meta_data: {
          player_info: {
            nationality_country_code: '',
            languages: [],
            playing_position: [],
            preferred_foot: '',
          },
          transfer_sum: {
            loan_interested: 'No',
            transfer_interested: 'No'
          },
          analyzed_matches: [{
            date: '',
            opponent: '',
            venue: '',
            comment: '',
            observation_type: ''
          }]
        },
        price: {
          value: 0,
          currency: 'USD'
        },
        headline: '',
        edit_mode: !!this.report,
        files: [],
        remove_attachment: {}
      };
    },
    computed: {
      priceEdit() {
        if (!this.hasBankAccount)
          return false;
        if (this.request) {
          if (this.request.type_request == 'position')
            return true;
          return false;
        }
        return true;
      },
      playerEditable() {
        if (this.playerId != null && this.playerId > 0)
          return false;
        if (this.report && this.report.player)
          return false;
        if (this.request && this.request.type_request != 'position')
          return false;

        return true;
      },
      position() {
        if (this.request && this.request.type_request == 'position')
          return true;
        return false;
      },
      agePlaceHolder() {
        if (this.position) {
          if (this.request.meta_data.min_age && this.request.meta_data.max_age)
            return `Between ${this.request.meta_data.min_age} and ${this.request.meta_data.max_age}`;
          if (this.request.meta_data.min_age)
            return `From ${this.request.meta_data.min_age}`;
          if (this.request.meta_data.max_age)
            return `Less than ${this.request.meta_data.max_age}`;
        }
        return 'Age';
      },
      weightPlaceHolder() {
        if (this.position) {
          if (this.request.meta_data.min_weight && this.request.meta_data.max_weight)
            return `Between ${this.request.meta_data.min_weight} and ${this.request.meta_data.max_weight}`;
          if (this.request.meta_data.min_weight)
            return `From ${this.request.meta_data.min_weight}`;
          if (this.request.meta_data.max_weight)
            return `Less than ${this.request.meta_data.max_weight}`;
        }
        return 'Weight';
      },
      heightPlaceHolder() {
        if (this.position) {
          if (this.request.meta_data.min_height && this.request.meta_data.max_height)
            return `Between ${this.request.meta_data.min_height} and ${this.request.meta_data.max_height}`;
          if (this.request.meta_data.min_height)
            return `From ${this.request.meta_data.min_height}`;
          if (this.request.meta_data.max_height)
            return `Less than ${this.request.meta_data.max_height}`;
        }
        return 'Height';
      }
    },
    beforeMount() {
      if (this.report) {
        this.meta_data = this.report.meta_data;
        this.price = this.report.price;
        this.headline = this.report.headline;
      }
      if (this.request) {
        this.price.value = this.request.price.value;
        this.price.currency = this.request.price.currency;

        if (!this.position)
          this.price.value = parseInt(this.request.bid_price.value);
        this.headline = 'Report on ';
        this.headline += this.request.meta_data.player_name ? this.request.meta_data.player_name : '';
        if (!this.request.player) {
          this.meta_data.player_info.languages = this.request.meta_data.languages;
          this.meta_data.player_info.preferred_foot = this.request.meta_data.preferred_foot;
          this.meta_data.player_info.residence_country_code = this.request.meta_data.residence_country_code;
          this.meta_data.player_info.nationality_country_code = this.request.meta_data.nationality_country_code;
          this.meta_data.player_info.playing_position = this.request.meta_data.playing_position;
        }
        this.$forceUpdate();
      }
    },
    methods: {
      handleSubmit(status) {
        this.$validator.validateAll().then(() => {
          if (this.errors.items.length == 0) {
            var report = {
              headline: this.headline,
              price: this.price,
              meta_data: this.meta_data,
              remove_attachment: this.remove_attachment,
              status,
              files: this.files
            };
            this.submitReport(report);
          } else {
            this.scrollToTop();
          }
        }).catch(this.scrollToTop);
      },
      scrollToTop() {
        setTimeout( () => {
          var error = $('.text-danger:not(:empty):first');
          var y = error.offset() ? error.offset().top - 200 : 0;
          $('html, body').animate({ scrollTop: y }, 200);
        }, 200);
      }
    }
  };
</script>
