<template>
  <form class="mx-2 my-auto d-inline w-50">
    <input @blur="lostFocus" @focus="gainedFocus" class="form-control" v-model="searchTerm"
      @keyup.prevent="getSearchResults({ searchTerm })"
      type="search" placeholder="Search" aria-label="Search" />
      <div class="position-absolute" v-if="displayResults" id="results-container" role="listbox">
        <result v-for="result in results" :info="result" :key="result.id" />
      </div>
  </form>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

#results-container {
  top: 62px;
  z-index: 1;
}

@media screen and (max-width: 768px) {
  #results-container {
    top: 140px;
  }
}
</style>

<script>
import { mapActions, mapGetters	} from 'vuex';
import AutoComplete from 'v-autocomplete';
import SearchResult from './components/SearchResult';

export default {
  name: 'SearchBar',
  components: {
    result: SearchResult
  },
  data() {
    return {
      searchTerm: '',
      searchHasFocus: false
    };
  },
  methods: {
    ...mapGetters(['searchResult']),
    ...mapActions(['getSearchResults']),
    gainedFocus() {
      this.searchHasFocus = true;
    },
    lostFocus() {
      setTimeout(() => {
        this.searchHasFocus = false;
      }, 500);
    },
    clearSearchTerm() {
      this.searchTerm = "";
      this.searchHasFocus = false;
    }
  },
  watch: {
    '$route': 'clearSearchTerm'
  },
  computed: {
    displayResults() {
      return this.searchHasFocus && this.results.length > 0;
    },
    results() {
      if(_.isEmpty(this.searchTerm) || !this.searchResult().value) { return []; }
      return this.searchResult().value;
    }
  }
};
</script>
