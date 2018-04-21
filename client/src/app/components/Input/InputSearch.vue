<template>
  <div>
      <input name="team" autocomplete="off" class="search" v-model="search" type="text" v-on:keyup="onkeyup(type,search)"  @blur="blur"/>
        <div class="search-results">
          <div v-for="(value, key, index) in searchResult.value" :key="index" @mousedown="setvalue(value)">
            <img src="https://unsplash.it/50/50" class="rounded-circle img-fluid">
            <p> {{value.display_name}}</p>
          </div>
        </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.search {
  -webkit-appearance: menulist;
  &:focus ~ .search-results {
    position: absolute;
    background: white;
    width: 220px;
    z-index: 10;
    display: block;
    overflow: hidden;
    overflow-y: scroll;
    div {
      padding: 10px 0 10px 15px;
      overflow: hidden;
      cursor: pointer;
      img {
        float: left;
      }
      p {
        padding-left: 10px;
        float: left;
        margin-top: 10px;
        color: black;
      }
      &:hover {
        background: #e6e1e1;
      }
    }
  }
}

.search-results {
  display: none;
}
</style>

<script>
import { mapActions } from 'vuex';
export default {
  name: 'InputSearch',
  props: ['onkeyup', 'searchResult', 'type'],
  data () {
    return {
      search: '',
      id: '',
      value: ''
    };
  },
  methods: {
    ...mapActions(['flushSearchResults']),
    setvalue (info) {
      this.id = info.id;
      this.value = info.display_name;
      this.search = info.display_name;
    },
    blur () {
      this.flushSearchResults();
      if (this.search === '') {
        this.id = '';
        this.value = '';
      }

      this.$emit('update:val', this.id);
      this.search = this.value;
    }
  }
};
</script>
