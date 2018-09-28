<template>
  <action-item>
    <span class="timeline-widget-button">
      <span>
        <icon  @click="toAssignments" name='arrow-left' scale="1.5"></icon>
      </span>
      <a @click="toAssignments">Go to <br/>All Assignments</a>
    </span>
  </action-item>
</template>

<style lang="scss" scoped>
</style>

<script>
import ActionsItem from 'app/components/ActionsItem';
import Icon from 'vue-awesome/components/Icon';
import 'vue-awesome/icons/edit';
import 'vue-awesome/icons/arrow-left';

export default {
  name: 'Actions',
  props:['id','status','updateStatus'],
  components: {
    'action-item': ActionsItem,
    icon: Icon
  },
  methods:{
    toAssignments(){
      this.$router.push({
        name: 'clubRequestList'
      })
    }
  }
};
</script>
