<template>
  <div class="contact-detail-box">
    <h5 class="contact-title"> {{ contactTitle }} </h5>
    <p class="contact"> {{ contactDetail }} </p>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.contact-title {
  color: $main-text-color;
}

.contact {
  color: $main-header-color;
}
</style>


<script>
export default {
  name: 'ContactDetail',
  props: ['contactTitle', 'contactDetail']
};
</script>
