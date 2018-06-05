<template>
  <span class="contents">
    <vselect :disabled="readonly" v-if="!readonly" ref="vSelect" v-model="model" :onChange="update" multiple :options="options"
      class="ft-input form-control multiple" :class="{'empty' : model.length == 0}" :placeholder="placeholder" />
    <div v-if="readonly" class="read">
      <span v-if="readonly" class="list" v-for="pos in model" :key="pos.id" :title="pos.label">{{pos.label}}</span>
    </div>
  </span>
</template>
<style lang="scss" scoped>
  .contents {
    display: contents;
  }

  .list {
    &:not(:last-child):after {
      content: ', ';
    }
  }
</style>

<script>
  import vSelect from 'vue-select';

  export default {
    name: 'PlayerPosition',
    props: ['value', 'readonly', 'placeholder'],
    components: {
      vselect: vSelect
    },
    mounted() {
      this.model = [];
      if (this.value.constructor == Array)
        for (var val in this.value) {
          const index = this.$options.filters.searchInObj(
            this.options,
            option => option.value === this.value[val]
          );
          if (index > 0) this.model.push(this.options[index]);
        }
      if (this.$refs.vSelect)
        this.$refs.vSelect.scrollTo = function () {};
    },
    data() {
      return {
        model: this.value,
        options: [{
            label: 'Goalkeeper',
            value: 'goalkeeper'
          },
          {
            label: 'Sweeper (Centre)',
            value: 'sweeper_centre'
          },
          {
            label: 'Defender (Right)',
            value: 'def_right'
          },
          {
            label: 'Defender (Left)',
            value: 'def_left'
          },
          {
            label: 'Wing-back (Right)',
            value: 'wing_back_right'
          },
          {
            label: 'Wing-back (Left)',
            value: 'wing_back_left'
          },
          {
            label: 'Defensive Midfielder (Centre)',
            value: 'def_mid_centre'
          },
          {
            label: 'Midfielder (Right)',
            value: 'midfielder_right'
          },
          {
            label: 'Midfielder (Left)',
            value: 'midfielder_left'
          },
          {
            label: 'Midfielder (Centre)',
            value: 'midfielder'
          },
          {
            label: 'Attacking Midfielder (Centre)',
            value: 'att_mid_centre'
          },
          {
            label: 'Winger (Right)',
            value: 'winger_right'
          }, {
            label: 'Winger (Left)',
            value: 'winger_left'
          },
          {
            label: 'Second Striker (Centre)',
            value: 'second_striker'
          }, {
            label: 'Striker (Centre)',
            value: 'striker'
          }
        ]
      };
    },
    methods: {
      update(val) {
        if (val) this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
      }
    }
  };
</script>
