<template>
  <router-link class="search-results-item" :to="`/users/${info.id}/profile`">
    <div class="arrow"></div>
    <img class="img-fluid" :src="info.avatar_url" />
    <p class="search-results-item-name">{{ info.display_name }}</p>
  </router-link>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.search-results-item {
  flex: 1 0 100%;
  display: flex;
  align-items: center;
  background-color: rgba(33, 34, 35, 0.95);
  padding: 10px 20px;
  height: 80px;
  color: $secondary-header-color;
  border-left: 7px solid $secondary-header-color;
  &:hover,
  &:focus {
    text-decoration: none;
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
</style>

<script>
export default {
  name: 'SearchResult',
  props: ['info'],
};
</script>
