<template>
  <p class="detail">
    <span class="detail-title">{{ detailTitle }}</span>
    {{ detailContent }}
  </p>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.detail {
  color: $main-text-color;

  .detail-title {
    color: $secondary-text-color;
  }
}
</style>


<script>
export default {
  name: 'InfoDetail',
  props: ['detailTitle', 'detailContent']
};
</script>
