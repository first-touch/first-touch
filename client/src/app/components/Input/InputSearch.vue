<template>
  <div class="ft-input">
    <div class="col-md-12 inner">
      <input name="team" autocomplete="off" class="search form-control" v-model="search" type="text" v-on:keyup="onkeyup(type,search)" :required="required"
        @blur="blur" />
      <div class="search-results">
        <div v-for="(value, index) in results" :key="index" @mousedown="setvalue(index)">
          <img src="https://unsplash.it/50/50" class="rounded-circle img-fluid">
          <p> {{value}}</p>
        </div>
        <div v-if="taggable && allowtag" @mousedown="newentry()">
          <img src="https://unsplash.it/50/50" class="rounded-circle img-fluid">
          <p> {{search}} (Non existing)</p>
        </div>
        <div v-if="!taggable && results.length == 0" >
          <p v-if="search != ''"> No result found </p>
          <p v-if="search == ''"> Type to search </p>
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
    &:focus~.search-results {
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
  import {
    mapActions
  } from 'vuex';
  export default {
    name: 'InputSearch',
    props: ['onkeyup', 'searchResult', 'type', 'taggable', 'edit','required'],
    data() {
      return {
        search: '',
        id: '',
        value: ''
      };
    },
    computed: {
      results: function () {
        return this.searchResult.value.map(r => r.display_name);
      },
      allowtag: function () {
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
        var info = this.searchResult.value[index];
        this.id = info.id;
        this.value = info.display_name;
        this.search = info.display_name;
      },
      newentry() {
        this.id = -1;
        this.value = this.search;
      },
      blur() {
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
