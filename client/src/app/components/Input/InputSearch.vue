<template>
  <div class="ft-input">
    <div class="col-lg-12 inner">
      <input  ref="input"
              type="text"
              name="team"
              class="search form-control"
              :class="readonly ? 'readonly':''"
              autocomplete="off"
              :placeholder="placeholder"
              :readonly="readonly"
              :required="required == true"

              v-model="search"
              @keyup="handleKey"
              @click="focus()"
              @blur="blur"  />

      <div class="search-results">
        <div v-for="(value, index) in results" :key="index" @mousedown="setvalue(index)" class="one-result" :class="{'focus' : index == resultFocus} "
          @mouseover="resultFocus = index">
          <div class="arrow"></div>
          <img src="https://unsplash.it/50/50" class="rounded-circle img-fluid">
          <p> {{value}}</p>
        </div>
        <div v-if="taggable && allowtag && (!minChar || search.length >= minChar) " @mousedown="newentry()" class="one-result new-result"
          :class="{'focus' : results.length == resultFocus}" @mouseover="resultFocus = results.length">
          <div class="arrow "></div>
          <img src="https://unsplash.it/50/50" class="rounded-circle img-fluid">
          <p> {{search}} (Add new entry)</p>
        </div>
        <div v-if="minChar && search.length < minChar">
          <p>Pleast type at least {{minChar}} chars </p>
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
    &:not(.readonly):focus~.search-results {
      position: absolute;
      background: white;
      width: 100%;
      z-index: 10;
      display: block;
      overflow: hidden;
      overflow-y: scroll;
      .one-result {
        flex: 1 0 100%;
        display: flex;
        align-items: center;
        background-color: rgba(33, 34, 35, 0.95);
        padding: 10px 20px;
        height: 80px;
        color: $secondary-header-color;
        border-left: 7px solid $secondary-header-color;

        p {
          margin-left: 1em;
        }
        &.new-result {
          border-color: rgba(255, 255, 255, 0.7);
          .arrow {
            color: rgba(255, 255, 255, 0.7);
          }
        }
        &.focus {
          text-decoration: none;
          background-color: rgba(98, 99, 100, 0.9);
          cursor: pointer;
        }
        .arrow {
          margin-left: -20px;
        }
        .img-fluid {
          max-height: 100%;
          border-radius: 50%;
        }
        .search-results-item-name {
          margin-left: 20px;
          margin-bottom: 0;
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
    props: [
      'onkeyup',
      'searchResult',
      'type',
      'taggable',
      'edit',
      'required',
      'minChar',
      'label',
      'readonly',
      'placeholder'
    ],
    data() {
      return {
        search: '',
        id: '',
        value: '',
        selected: null,
        resultFocus: -1
      };
    },
    computed: {
      results: function () {
        if (this.searchResult.value && this.searchResult.value.constructor === Array)
          return this.searchResult.value.map(r => r[this.label]);
        return [];
      },
      allowtag: function () {
        if (this.search == '')
          return false;
        for (var i in this.results) {
          if (this.results[i] == this.search)
            return false;
        }
        return true;
      }
    },
    created() {
      if (this.edit) {
        this.search = this.value = this.edit.search;
        this.id = this.edit.id;
      }
    },
    methods: {
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
        this.selected = null;
      },
      blur() {
        if (this.search === '') {
          this.clear();
        }
        this.search = this.value;
        this.$emit('update:val', this.id);

        if (this.taggable && this.id == -1) {
          this.$emit('update:search', this.value);
          this.$emit('update:obj', {
            id: -1,
            name: this.search
          });
        } else {
          this.$emit('update:obj', this.selected);
        }
      },
      focus() {
        this.startSearch();
      },
      handleKey(event) {
        if ((event.keyCode >= 48 && event.keyCode <= 57) ||
          (event.keyCode >= 65 && event.keyCode <= 90) ||
          event.keyCode == 8
        ) this.startSearch();
        if (event.keyCode == 40 && this.resultFocus < this.results.length)
          this.resultFocus++;
        if (event.keyCode == 38 && this.resultFocus > -1)
          this.resultFocus--;
        if (event.keyCode == 13) {
          if (this.resultFocus == -1)
            this.clear
          else if (this.resultFocus != this.results.length)
            this.setvalue(this.resultFocus);
          else
            this.newentry();
          this.$refs.input.blur();
        }
      },
      startSearch() {
        if (!this.minChar || this.search.length >= this.minChar) {
          this.resultFocus = -1;
          this.onkeyup(this.type, this.search);
        }
      }
    }
  };
</script>
