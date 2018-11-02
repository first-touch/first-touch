<template>


  <div class="sidenav-right">
   <div class="searchbar-top">
 <div class="input-group">



<b-dropdown id="about-drpdwn" text="About" class="right_sidebar_box">
    <b-dropdown-item>HELP</b-dropdown-item>
    <b-dropdown-item>LEGAL</b-dropdown-item>
    <b-dropdown-item>CONTACT</b-dropdown-item>
  </b-dropdown>

<b-dropdown id="setting-drpdwn" text="Settings" class="right_sidebar_box">
    <b-dropdown-item>LANGUAGE</b-dropdown-item>
    <b-dropdown-item>EDIT PROFILE</b-dropdown-item>
    <b-dropdown-item>UPGRADE</b-dropdown-item>
    <b-dropdown-item>LOGOUT</b-dropdown-item>
  </b-dropdown>

   </div>
 </div>
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
@import '~stylesheets/variables.scss';

.sidenav-right {
  box-shadow: -2px -2px 2px #555;
  background-color: #343434;
  padding-top: 40px;
  height:100%;
  .nav-list {
    display: flex;
    height: 119px;
    align-items: center;
    justify-content: space-around;
    text-align: left;
    float: left;
    width: 62%;
}
    .nav-item {
      text-transform: uppercase;
          padding-bottom: 50px;

      button {
        background: transparent;
        border: none;
        text-transform: uppercase;
        padding: 0;
      }
      a:hover,
      button:hover {
        color: #fff;
        text-decoration: none;
        cursor: pointer;
      }
    }
  }




.dropdown {
    position: relative;
    display: inline-block;
	margin-right:30px;



}
.dropdown a {
    font-size: 13px;
    font-weight: normal;
    letter-spacing: 2px;

}
.hover_border {
    margin-left: 24px;
}

.hover_border a:hover {
    border-top: 6px solid#a6cf4c;
    padding-top: 6px;

}
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #424242;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    padding:10px 0;
    z-index: 1;
	    margin-top: 2px;
          margin-left: 22px;
}
.dropdown-content img {
    position: relative;
    top: -14px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}


.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown-content ul { list-style:none;}

.dropdown-content li {
    border-bottom: 1px solid#929292;
    padding: 6px 0;
	    margin: 0 10px;
      display: block;
}

.dropdown-content a {
    color: #929292;
    font-size: 14px;
    text-decoration: none;
	font-family: 'ubunturegular';
    font-weight: normal;
	letter-spacing:2px;
}
.dropdown-content a:hover { color:#fff;
}




.dropdown-two {
    position: relative;
    display: inline-block;

}
.dropdown-two a {
    font-size: 13px;
    font-weight: normal;
    letter-spacing: 2px;
	 font-family: 'ubunturegular';
}


.dropdown-content-two {
    display: none;
    position: absolute;
    background-color: #424242;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    padding:10px 0;
    z-index: 1;
	    margin-top: 2px;
          margin-left: 12px;
}

.dropdown-two:hover .dropdown-content-two {
    display: block;
}

.dropdown-content-two ul { list-style:none;}

.dropdown-content-two li {
    border-bottom: 1px solid#929292;
    padding: 6px 0;
	    margin: 0 10px;
      display: block;
}

.dropdown-content-two a {
    color: #929292;
    font-size: 14px;
    text-decoration: none;
	font-family: 'ubunturegular';
    font-weight: normal;
	letter-spacing:2px;
}



.dropdown-content-two a:hover { color:#fff;}

.dropdown-content-two img {
    position: relative;
    top: -14px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}







</style>

<script>
export default {
  name: 'NotificationSidebar',
};
</script>
