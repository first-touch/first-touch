<template>
  <div>
    <vselect v-model="model" :disabled="disabled" :onChange="update" :options="options" class="ft-input" placeholder="Please select a country"
    />
  </div>
</template>

<style lang="scss" scoped>

</style>

<script>
import vSelect from 'vue-select';

export default {
  name: 'StripeCountrySelect',
  components: {
    vselect: vSelect
  },
  props: ['value', 'disabled', 'filter'],
  data() {
    return {
      model: null,
      options: [
        {
          label: 'Austria',
          value: 'AT',
          bank_column_needed: ['iban']
        },
        {
          label: 'Australia',
          value: 'AU',
          bank_column_needed: ['bsb', 'account_number']
        },
        {
          label: 'Belgium',
          value: 'BE',
          bank_column_needed: ['iban']
        },
        {
          label: 'Canada',
          value: 'CA',
          bank_column_needed: ['transit_number', 'institution_number', 'account_number']
        },
        {
          label: 'Germany',
          value: 'DE',
          bank_column_needed: ['iban']
        },
        {
          label: 'Switzerland',
          value: 'CH',
          bank_column_needed: ['iban']
        },
        {
          label: 'Denmark',
          value: 'DK',
          bank_column_needed: ['iban']
        },
        {
          label: 'Spain',
          value: 'ES',
          bank_column_needed: ['iban']
        },
        {
          label: 'Finland',
          value: 'FI',
          bank_column_needed: ['iban']
        },
        {
          label: 'France',
          value: 'FR',
          bank_column_needed: ['iban']
        },
        {
          label: 'United Kingdom',
          value: 'GB',
          bank_column_needed: ['sort_code', 'account_number']
        },
        {
          label: 'Hong Kong',
          value: 'HK',
          bank_column_needed: ['clearing_code', 'branch_code', 'account_number']
        },
        {
          label: 'Ireland',
          value: 'IE',
          bank_column_needed: ['iban']
        },
        {
          label: 'Italy',
          value: 'IT',
          bank_column_needed: ['iban']
        },
        {
          label: 'Japan',
          value: 'JP',
          bank_column_needed: [
            'bank_name',
            'branch_name',
            'bank_code',
            'branch_code',
            'account_number',
            'account_holder_name'
          ]
        },
        {
          label: 'Luxembourg',
          value: 'LU',
          bank_column_needed: ['iban']
        },
        {
          label: 'Netherlands',
          value: 'NL',
          bank_column_needed: ['iban']
        },
        {
          label: 'Norway',
          value: 'NL',
          bank_column_needed: ['iban']
        },
        {
          label: 'New Zealand',
          value: 'NZ',
          bank_column_needed: ['routing_number', 'account_number']
        },
        {
          label: 'Portugal',
          value: 'PT',
          bank_column_needed: ['iban']
        },
        {
          label: 'Sweden',
          value: 'SE',
          bank_column_needed: ['iban']
        },
        {
          label: 'Singapore',
          value: 'SG',
          bank_column_needed: ['bank_code', 'branch_code', 'account_number']
        },
        {
          label: 'United States',
          value: 'US',
          bank_column_needed: ['routing_number', 'account_number']
        }
      ]
    };
  },
  watch: {
    value() {
      this.refactorValue();
    },
    filter() {
      this.refactorValue();
    },
    model() {
      this.$emit('update:obj', this.model);
    }
  },
  mounted() {
    this.refactorValue();
  },
  methods: {
    update(val) {
      if (val) {
        this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
      }
    },
    refactorValue() {
      const index = this.$options.filters.searchInObj(
        this.options,
        option => option.value === this.value
      );
      this.model = this.options[index];

      var newOptions = [];
      if (this.filter && this.filter.length > 0) {
        this.filter.forEach(e => {
          const index = this.$options.filters.searchInObj(
            this.options,
            option => option.value === e
          );
          if (this.options[index]) newOptions.push(this.options[index]);
        });
        this.options = newOptions;
      }
    }
  }
};
</script>
