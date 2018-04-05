<template>
  <div>
    <select v-model="model" multiple @change="update" class="col-md-5">
      <option disabled value="">Languages</option>
      <option v-for="(value, key) in languagesOrdered" :key="key" :value="value[1]">
        {{value[0]}}
      </option>
    </select>
    <p v-for="val in model" :key="val.id"> {{languages[val]}}
      <span class="remove" @click="removeValue(val)">X</span>
    </p>
  </div>
</template>


<style lang="scss" scoped>
@import '~stylesheets/variables';
div {
  overflow: hidden;
  select {
    float: left;
    option {
      &:not(:first-child) {
        display: none;
      }
    }
    max-height: 30px;
    overflow: hidden;
    -webkit-appearance: menulist;
    &:focus {
      overflow-y: scroll;
      max-height: none;
      -webkit-appearance: unset;
      option {
        display: block;
      }
    }
  }
  p {
    float: left;
    margin-left: 5px;
    text-transform: capitalize;
    background: #138496;
    min-width: 110px;
    padding: 3px;
    border-radius: 5px;
    color: white;
    .remove {
      float: right;
      cursor: pointer;
    }
  }
  display: inline-block;
  padding: 0;
  margin: 0;
}
</style>

<script>
import countrydata from 'country-data';

export default {
  name: 'Language',
  props: ['value'],
  data() {
    return {
      model: this.value
    };
  },
  methods: {
    update() {
      this.$emit('update:val', this.model);
    },
    removeValue(value) {
      var index = this.model.indexOf(value);
      if (index > -1) {
        this.model.splice(index, 1);
      }
    }
  },
  computed: {
    languagesOrdered() {
      var arr = [];
      $.each(this.languages, function(key, value) {
        arr.push([value, key]);
      });
      arr.sort();
      return arr;
    },
    languages() {
      var languages = {};
      var multiple = [];
      $.each(countrydata.languages, function(key, value) {
        if (value.alpha2 && !multiple[value.name]) {
          multiple[value.name] = 1;
          languages = Object.assign({}, languages, {
            [value.alpha2]: value.name
          });
        }
      });
      return languages;
    }
  }
};
</script>
