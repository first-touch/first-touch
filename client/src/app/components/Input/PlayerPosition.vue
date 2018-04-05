<template>
  <div>
    <select v-model="model" multiple @change="update" class="col-md-5">
      <option disabled value="">Positions</option>
      <option value="goalkeeper">GoalKeeper</option>
      <option value="defender">Defender</option>
      <option value="midfielder">Midfielder</option>
      <option value="winger">Winger</option>
      <option value="striker">Striker</option>
    </select>
    <p v-for="val in model" :key="val.id"> {{val}}
      <span class="remove" @click="removeValue(val)">X</span>
    </p>
  </div>
</template>

<style lang="scss" scoped>
  @import "~stylesheets/variables";
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
  export default {
    name: 'PlayerPosition',
    props: ['value'],
    data () {
      return {
        model: this.value
      };
    },
    methods: {
      update () {
        this.$emit('update:val', this.model);
      },
      removeValue (value) {
        var index = this.model.indexOf(value);
        if (index > -1) {
          this.model.splice(index, 1);
        }
      }
    }
  };
</script>
