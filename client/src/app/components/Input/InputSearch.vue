<template>
  <div class="ft-input">
    <div class="col-md-12 inner">
      <input name="team" autocomplete="off" class="search form-control" v-model="search" type="text" v-on:keyup="startSearch" :required="required"
        @blur="blur" @click="focus()" />
      <div class="search-results">
        <div v-for="(value, index) in results" :key="index" @mousedown="setvalue(index)">
          <img src="https://unsplash.it/50/50" class="rounded-circle img-fluid">
          <p> {{value}}</p>
        </div>
        <div v-if="minChar && search.length < minChar">
          <p>Pleast type at least {{minChar}} chars </p>
        </div>
        <div v-if="taggable && allowtag && (!minChar || search.length >= minChar) " @mousedown="newentry()">
          <img src="https://unsplash.it/50/50" class="rounded-circle img-fluid">
          <p> {{search}} (Non existing)</p>
        </div>
        <div v-if="!taggable && results.length == 0">
          <p v-if="search != '' && (!minChar || search.length >= minChar)  "> No result found </p>
          <p v-if="search == '' && !minChar"> Type to search </p>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.inner {
  padding: 0;
}

.search {
  -webkit-appearance: menulist;
  &:focus ~ .search-results {
    position: absolute;
    background: white;
    width: 100%;
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
  props: ['onkeyup', 'searchResult', 'type', 'taggable', 'edit', 'required', 'minChar', 'label'],
  data() {
    return {
      search: '',
      id: '',
      value: '',
      selected: null
    };
  },
  computed: {
    results: function() {
      if (this.searchResult.value.constructor === Array)
        return this.searchResult.value.map(r => r[this.label]);
      return [];
    },
    allowtag: function() {
      return this.search != '';
    }
  },
  created() {
    if (this.edit) {
      this.search = this.value = this.edit.search;
      this.id = this.edit.id;
    }
  },
  methods: {
    ...mapActions(['flushSearchResults']),
    setvalue(index) {
      var info = (this.selected = this.searchResult.value[index]);
      this.id = info.id;
      this.value = info[this.label];
      this.search = info[this.label];
    },
    newentry() {
      this.id = -1;
      this.value = this.search;
    },
    clear() {
      this.search = '';
      this.id = '';
      this.value = '';
    },
    focus() {
      this.startSearch();
    },
    blur() {
      this.flushSearchResults();
      if (this.search === '') {
        this.clear();
      }
      this.search = this.value;
      this.$emit('update:val', this.id);
      this.$emit('update:search', this.value);

      if(this.taggable && this.id == -1){
        this.$emit('update:obj', {id: -1, name: this.search});
      }
      else{
        this.$emit('update:obj', this.selected);
      }

    },
    startSearch() {
      if (this.search != '' && (!this.minChar || this.search.length >= this.minChar))
        this.onkeyup(this.type, this.search);
    }
  }
};
</script>
