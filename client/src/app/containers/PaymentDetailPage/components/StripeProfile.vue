<template>
<div>
  <div class="row row-form col-lg-12">
    <div class="col-lg-6" v-if="requirements.indexOf('individual.first_name') >= 0">
      <label class="col-lg-12 required">First Name</label>
      <input class="form-control col-lg-12" required name="first_name" v-model="profile.individual.first_name">
    </div>
    <div class="col-lg-6" v-if="requirements.indexOf('individual.last_name') >= 0">
      <label class="col-lg-12 required">Last Name</label>
      <input class="form-control col-lg-12" required name="last_name" v-model="profile.individual.last_name">
    </div>
    <div class="col-lg-6" v-if="requirements.indexOf('company.name') >= 0">
      <label class="col-lg-12 required">Business Name</label>
      <input class="form-control col-lg-12" required name="business_name" v-model="profile.company.name">
    </div>
  </div>
  <div class="row row-form col-lg-12" v-if="requirements.indexOf('relationship.owner') >= 0">
    <label class="col-lg-12 required">Company Owners</label>
    <div class="row col-lg-12" v-for="(owner, index) in owners" :key="owner.id">
      <div class="col-lg-5">
        <label class="col-lg-12 required">First Name</label>
        <input type="text" class="form-input col-lg-12" v-model="owner.first_name">
      </div>
      <div class="col-lg-5">
        <label class="col-lg-12 required">Last Name</label>
        <input type="text" class="form-input col-lg-12" v-model="owner.last_name">
      </div>
      <div class="remove col-lg-2" v-if="owners.length > 1" @click="removeOwners(index)">
        <icon name='trash'></icon>
      </div>
    </div>
    <button class="button row add-match" @click="addOwners">Add Owners</button>
  </div>
  <div class="row row-form col-lg-12">
    <div class="col-lg-6" v-if="requirements.indexOf('individual.dob.year') >= 0">
      <label class="col-lg-12 required">Date of birth</label>
      <ftdatepicker class="form-control col-lg-12" required :disabled="disabledDate" v-on:update:val="dob = $event" :value="disabledDate.from" />
    </div>
    <div class="col-lg-6" v-if="requirements.indexOf('individual.id_number') >= 0">
      <label class="col-lg-12 required">Personal Id Number</label>
      <input class="form-control col-lg-12" name="personal_id_number" required v-model="profile.individual.id_number">
    </div>
    <div class="col-lg-6" v-if="requirements.indexOf('company.tax_id') >= 0">
      <label class="col-lg-12 required">Business tax id</label>
      <input class="form-control col-lg-12" name="personal_id_number" required v-model="profile.company.tax_id">
    </div>
    <div class="col-lg-6" v-if="requirements.indexOf('individual.ssn_last_4') >= 0">
      <label class="col-lg-12 required">SSN last 4</label>
      <input class="form-control col-lg-12" name="ssn_last_4" type="number" min="0" required max="9999" v-model="profile.individual.ssn_last_4">
    </div>
  </div>

  <div class="row row-form col-lg-12" v-if="requirements.indexOf('company.address') >= 0">
    <label class="col-lg-12 required">Address</label>
    <div class="row col-lg-12">
      <div class="col-lg-6" v-if="requirements.indexOf('company.address.state') >= 0">
        <label class="col-lg-12 required">State</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.company.address.state">
      </div>
      <div class="col-lg-6">
        <label class="col-lg-12 required">City</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.company.address.city">
      </div>
    </div>
    <div class="row col-lg-12">
      <div class="col-lg-6" v-if="requirements.indexOf('company.address.line1') >= 0">
        <label class="col-lg-12 required">Address Line</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.company.address.line1">
      </div>
      <div class="col-lg-6" v-if="requirements.indexOf('company.address.postal_code') >= 0">
        <label class="col-lg-12 required">Postal Code</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.company.address.postal_code">
      </div>
    </div>
  </div>
  <div class="row row-form col-lg-12" v-if="requirements.indexOf('individual.address.city') >= 0">
    <label class="col-lg-12 required">Personnal Address</label>
    <div class="row col-lg-12">
      <div class="col-lg-6" v-if="requirements.indexOf('individual.address.state') >= 0">
        <label class="col-lg-12 required">State</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.individual.address.state">
      </div>
      <div class="col-lg-6">
        <label class="col-lg-12 required">City</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.individual.address.city">
      </div>
    </div>
    <div class="row col-lg-12">
      <div class="col-lg-6" v-if="requirements.indexOf('individual.address.line1') >= 0">
        <label class="col-lg-12 required">Address Line</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.individual.address.line1">
      </div>
      <div class="col-lg-6" v-if="requirements.indexOf('individual.address.postal_code') >= 0">
        <label class="col-lg-12 required">Postal Code</label>
        <input class="col-lg-12 form-control" name="line1" required v-model="profile.individual.address.postal_code">
      </div>
    </div>
  </div>
</div>
</template>

<script>
import FtDatepicker from 'app/components/Input/FtDatepicker';
import _ from 'lodash';

export default {
  components:{
    ftdatepicker: FtDatepicker,
  },
  props: {
    value: Object,
    requirements: Array
  },
  data(){
    return {
      disabledDate: { from: new Date() },
      profile: {
        individual: {
          dob: {},
          first_name: "",
          last_name: "",
          id_number: "",
          address: {
            city: "",
            line1: "",
            postal_code: "",
            state: ""
          }
        },
        company: {
          tax_id: "",
          address: {
            city: "",
            line1: "",
            postal_code: "",
            state: ""
          }
        }
      }
    }
  },
  beforeMount(){
    var date = new Date();
    date.setFullYear(date.getFullYear() - 18);
    this.disabledDate.from = date;

    this.profile.individual.dob = Object.assign({}, this.profile.individual.dob, {
        day: date.getDay() + 1,
        month: date.getMonth() + 1,
        year: date.getFullYear()
    });

  },
  watch: {
    value: {
      deep: true,
      immediate: true,
      handler: function(to){
        this.profile = _.merge(this.profile, to);
      }
    },
    profile: {
      deep: true,
      immediate: true,
      handler: function(to){
        this.$emit('input', to);
      }
    }
  }

}
</script>
