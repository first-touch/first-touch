<template>
  <div class="sidenav-right">
    <div class="info-blk">
      <div class="info-blk-header">
        <router-link to="#" class="info-blk-header-name">
          Notifications
        </router-link>
        <router-link to="/notification" class="info-blk-header-seemore">
          See More
        </router-link>
      </div>
      <div class="info-blk-body">
        <div class="list">
          <div class="item">
            <span class="person">Jose Mourinho</span> would like to get in touch
          </div>
          <div class="item">
            <span class="person">Jorge Campos</span> liked you post
          </div>
          <div class="item">
            <span class="person">Tony Media</span> would like to get in touch
          </div>
        </div>
      </div>
    </div>
    <div class="info-blk">
      <div class="info-blk-header">
        <router-link to="#" class="info-blk-header-name">
          Events
        </router-link>
        <router-link to="/events" class="info-blk-header-seemore">
          See More
        </router-link>
      </div>
      <div class="info-blk-body">
        <div class="list">
          <div class="item">
            <div class="event-name">UEFA Champions League Final Match</div>
            <div class="duel"><span class="team">Real Madrid</span> x <span class="team">Aletico Madrid</span></div>
            <div class="time">28 May at 18:30</div>
            <div class="venue">San Siro Stadium, Milan, Italy</div>
          </div>
          <div class="item">
            <div class="event-name">BBVA Spanish League Match</div>
            <div class="duel"><span class="team">Real Madrid</span> x <span class="team">Valenvia CF</span></div>
            <div class="time">04 June at 18:30</div>
            <div class="venue">Santiago Bernabeu Stadium, Madrid, Spain</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.sidenav-right {
  margin-top: 119px;
  padding-top: 5px;
  height: calc(100vh - 119px);
  overflow-y: scroll;
  box-shadow: -2px 2px 2px #555;
}
</style>

<script>
export default {
  name: 'NotificationSidebar',
};
</script>
